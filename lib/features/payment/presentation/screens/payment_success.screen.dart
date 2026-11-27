import 'package:flutter/material.dart';
import 'package:google_samsung_pay/core/routes/route_names.dart';

import 'package:google_samsung_pay/core/res/colors/colors.app.dart';
import 'package:google_samsung_pay/core/widgets/organisms/card_widgets.dart';
import 'package:google_samsung_pay/core/widgets/molecules/flow_widgets.dart';


// ------------------------------------------------------------------
// 08 — Thanh toán thành công — Bước 4/4
// ------------------------------------------------------------------
class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowScreen(
      screen: 8,
      step: 4,
      flowLabel: 'Samsung Pay',
      pillLabel: 'SAMSUNG PAY • 4/4',
      title: '08 · Thanh toán thành công!',
      subtitle: 'Đã thanh toán — 50.000đ',
      primaryLabel: 'Xem lịch đặt sân',
      onPrimary: () => Navigator.of(context).pushNamed(RouteNames.initial),
      child: Column(
        children: [
          const SizedBox(height: 16),
          const GradientTick(screen: 8, size: 104),
          const SizedBox(height: AppSpacing.section),
          // Ảnh thẻ riêng của màn 8 — bắt buộc theo spec.
          const WhiteCard(
            brand: 'visa',
            last4: '4242',
            cardNumber: '4242 •••• •••• 4242',
            height: 180,
          ),
          const SizedBox(height: AppSpacing.section),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.cardPadding),
            decoration: BoxDecoration(
              color: AppColors.backgroundAlt,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: const [
                Text('MÃ ĐẶT SÂN',
                    style: TextStyle(
                        fontSize: 11,
                        color: AppColors.greyText,
                        letterSpacing: 1)),
                SizedBox(height: 4),
                Text('BDM-20261119-03',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                SizedBox(height: 8),
                Text('Sân Cầu Lông Phú Thọ - Sân 3 • 19/11 18:00-19:00',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: AppColors.greyText)),
                SizedBox(height: 4),
                Text('Còn lại 50.000đ thanh toán tại sân',
                    style: TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
