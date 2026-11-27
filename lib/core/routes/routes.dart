import 'package:flutter/material.dart';
import 'package:google_samsung_pay/core/extensions/no_swipe_route_material.extension.dart';
import 'package:google_samsung_pay/core/routes/route_names.dart';
import 'package:google_samsung_pay/core/widgets/layouts/base.scafford.dart';
import 'package:google_samsung_pay/features/auth/presentation/screens/fingerprint_error.screen.dart';
import 'package:google_samsung_pay/features/auth/presentation/screens/otp.screen.dart';
import 'package:google_samsung_pay/features/auth/presentation/screens/otp_error.screen.dart';
import 'package:google_samsung_pay/features/card_registration/presentation/screens/add_card.screen.dart';
import 'package:google_samsung_pay/features/card_registration/presentation/screens/add_card_success.screen.dart';
import 'package:google_samsung_pay/features/card_registration/presentation/screens/payment_method.screen.dart';
import 'package:google_samsung_pay/features/home/presentation/screens/home.screen.dart';
import 'package:google_samsung_pay/features/payment/presentation/screens/card_declined.screen.dart';
import 'package:google_samsung_pay/features/payment/presentation/screens/confirm_payment.screen.dart';
import 'package:google_samsung_pay/features/payment/presentation/screens/payment_success.screen.dart';
import 'package:google_samsung_pay/features/payment/presentation/screens/samsung_pay.screen.dart';
import 'package:google_samsung_pay/features/payment/presentation/screens/samsung_pay_auth.screen.dart';

/// Routes.generateRoute kiểu shopping — mọi màn đi qua RouteNames.
class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.initial:
      case RouteNames.home:
        return NoSwipeMaterialPageRoute(builder: (_) => const HomeScreen());

      // Flow 1 — Đăng ký thẻ (Bước 1/4 -> 4/4)
      case RouteNames.paymentMethod:
        return MaterialPageRoute(
          builder: (_) => const PaymentMethodScreen(),
        );
      case RouteNames.addCard:
        return MaterialPageRoute(builder: (_) => const AddCardScreen());
      case RouteNames.otp:
        return MaterialPageRoute(builder: (_) => const OtpScreen());
      case RouteNames.addCardSuccess:
        return MaterialPageRoute(
          builder: (_) => const AddCardSuccessScreen(),
        );

      // Flow 2 — Samsung Pay (Bước 1/4 -> 4/4)
      case RouteNames.samsungPay:
        return MaterialPageRoute(builder: (_) => const SamsungPayScreen());
      case RouteNames.samsungPayAuth:
        return MaterialPageRoute(
          builder: (_) => const SamsungAuthScreen(),
        );
      case RouteNames.confirmPayment:
        return MaterialPageRoute(
          builder: (_) => const ConfirmPaymentScreen(),
        );
      case RouteNames.paymentSuccess:
        return MaterialPageRoute(
          builder: (_) => const PaymentSuccessScreen(),
        );

      // Màn lỗi 09-11
      case RouteNames.otpError:
        return MaterialPageRoute(builder: (_) => const ErrorOtpScreen());
      case RouteNames.cardDeclined:
        return MaterialPageRoute(
          builder: (_) => const ErrorCardDeclinedScreen(),
        );
      case RouteNames.fingerprintError:
        return MaterialPageRoute(
          builder: (_) => const ErrorFingerprintScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const BaseScafford(child: null),
        );
    }
  }
}
