import 'package:flutter/material.dart';
import 'package:google_samsung_pay/core/routes/route_names.dart';

import 'package:google_samsung_pay/core/res/colors/colors.app.dart';
import 'package:google_samsung_pay/core/widgets/organisms/card_widgets.dart';
import 'package:google_samsung_pay/core/widgets/molecules/flow_widgets.dart';


// ------------------------------------------------------------------
// 10 — Thẻ bị từ chối — LỖI THANH TOÁN • 2/3
// ------------------------------------------------------------------
class ErrorCardDeclinedScreen extends StatelessWidget {
  const ErrorCardDeclinedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowScreen(
      screen: 10,
      step: 3,
      flowLabel: 'Samsung Pay',
      title: 'Thẻ bị từ chối',
      subtitle:
          'Ngân hàng từ chối giao dịch 50.000đ cho Visa •• 4242.',
      pillLabel: 'LỖI THANH TOÁN • 2/3',
      primaryLabel: 'Thử thẻ khác',
      onPrimary: () => Navigator.of(context).pushNamed(RouteNames.addCard),
      secondaryLabel: 'Quay lại phương thức thanh toán',
      onSecondary: () => Navigator.of(context).pushNamed(RouteNames.paymentMethod),
      child: Column(
        children: [
          const SizedBox(height: 8),
          // Thẻ Visa mờ 55%, viền đỏ, badge X đỏ góc trên-phải
          // (audit 25/11: khỏi che logo Visa).
          const WhiteCard(
            brand: 'visa',
            last4: '4242',
            cardNumber: '4242 •••• •••• 4242',
            dimmed: true,
            redBorder: true,
            showBadgeX: true,
          ),
          const SizedBox(height: AppSpacing.section),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.cardPadding),
            decoration: BoxDecoration(
              color: AppColors.errorRedPale,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              'Vui lòng thử thẻ khác hoặc liên hệ ngân hàng.',
              style: TextStyle(color: AppColors.errorRed, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
