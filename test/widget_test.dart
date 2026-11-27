import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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
}
