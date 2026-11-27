import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_samsung_pay/core/data/network/base_api_services.dart';
import 'package:google_samsung_pay/core/data/network/network_api_services.dart';
import 'package:google_samsung_pay/core/environment/environment.dart';
import 'package:google_samsung_pay/core/res/app.context.extension.dart';
import 'package:google_samsung_pay/core/routes/route_names.dart';
import 'package:google_samsung_pay/core/routes/routes.dart';
import 'package:google_samsung_pay/core/services/session_manager.dart';
import 'package:google_samsung_pay/features/auth/presentation/provider/auth.provider.dart';
import 'package:google_samsung_pay/features/card_registration/presentation/provider/card.provider.dart';
import 'package:google_samsung_pay/features/payment/presentation/provider/payment.provider.dart';
import 'package:provider/provider.dart';

/// Đăng ký thẻ & Samsung Pay — Trắng Minimal (Apple Pay style).
/// Clone từ Figma 'Đăng ký thẻ & Samsung Pay - Trắng Minimal',
/// spec: ~/workspace/samsung-pay-card-flow-spec.md (11 màn).
/// Kiến trúc core/features copy từ shopping (vnb_ban_hang):
/// Service -> Repository -> UseCase -> ViewModel, provider + dotenv.
/// KHÔNG Firebase / deeplink / notification / AI / video.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };

  // Load environment (.env.develop) kiểu shopping — file có sẵn trong
  // repo, nếu thiếu thì app vẫn chạy với dữ liệu mẫu local.
  try {
    await dotenv.load(fileName: Environment.fileName);
  } catch (e) {
    print('⚠️ dotenv load failed (running with local demo data): $e');
  }

  await SessionManager.initialize();

  runApp(
    MultiProvider(
      providers: [
        ...CoreProvider.coreProviders,
        ...AuthProvider.authProviders,
        ...CardProvider.cardProviders,
        ...PaymentProvider.paymentProviders,
      ],
      child: const MyApp(),
    ),
  );
}

class CoreProvider {
  static List<dynamic> coreProviders = [
    Provider<BaseApiServices>(create: (context) => NetworkApiServices()),
  ];
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.resources.colors;
    final dimensions = context.resources.dimensions;

    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Đăng ký thẻ & Samsung Pay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: colors.primaryColor,
        scaffoldBackgroundColor: colors.backgroundColor,
        cardColor: colors.backgroundColor,
        fontFamily: 'Roboto',
        appBarTheme: AppBarTheme(
          backgroundColor: colors.backgroundColor,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          foregroundColor: colors.itemColor,
          centerTitle: true,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: colors.formBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: colors.volt, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: dimensions.sidePadding - 8,
            vertical: 14,
          ),
        ),
      ),
      onGenerateRoute: Routes.generateRoute,
      initialRoute: RouteNames.initial,
    );
  }
}
