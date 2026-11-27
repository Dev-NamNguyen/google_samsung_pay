import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_samsung_pay/core/widgets/organisms/card_widgets.dart';
import 'package:google_samsung_pay/main.dart';

void main() {
  testWidgets('App boots to the 11-screen list', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.textContaining('Đăng ký thẻ'), findsWidgets);
    expect(find.text('01'), findsOneWidget);
    // Màn 11 nằm dưới fold của ListView — scroll xuống mới thấy.
    await tester.scrollUntilVisible(find.text('11'), 500);
    await tester.pumpAndSettle();
    expect(find.text('11'), findsOneWidget);
    expect(find.text('Vân tay sai'), findsOneWidget);
  });

  // Hồi quy overflow màn OTP (03/09): 6 ô cố định 48px + gap 12px = 348px,
  // rộng hơn 342px nội dung của màn 390 nên Row tràn 6px, màn hẹp tràn
  // nhiều hơn. Bơm OtpBoxes ở các chiều rộng 320/360/390 và bắt mọi lỗi
  // FlutterError (overflow báo qua FlutterError.onError).
  testWidgets('OTP boxes do not overflow at 320/360/390 width',
      (WidgetTester tester) async {
    final errors = <FlutterErrorDetails>[];
    final oldOnError = FlutterError.onError;
    FlutterError.onError = (details) {
      if (details.toString().contains('overflow')) errors.add(details);
    };
    addTearDown(() => FlutterError.onError = oldOnError);

    for (final width in [320.0, 360.0, 390.0]) {
      final controllers =
          List.generate(6, (_) => TextEditingController(text: '4'));
      addTearDown(() {
        for (final c in controllers) {
          c.dispose();
        }
      });
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: width - 48, // trừ padding 2 bên 24 như FlowScreen
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OtpBoxes(controllers: controllers),
                    const SizedBox(height: 16),
                    const OtpBoxes(error: true, fixedDigits: '428516'),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('4'), findsWidgets);
    }
    expect(errors, isEmpty);
  });
}
