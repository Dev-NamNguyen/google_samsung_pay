import 'package:flutter/material.dart';
import 'package:google_samsung_pay/core/routes/route_names.dart';

import 'package:google_samsung_pay/core/res/colors/colors.app.dart';
import 'package:google_samsung_pay/core/widgets/organisms/card_widgets.dart';
import 'package:google_samsung_pay/core/widgets/molecules/flow_widgets.dart';


// ------------------------------------------------------------------
// 04 — Thêm thẻ thành công — Bước 4/4
// ------------------------------------------------------------------
class AddCardSuccessScreen extends StatelessWidget {
  const AddCardSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowScreen(
      screen: 4,
      step: 4,
      flowLabel: 'Đăng ký thẻ',
      title: '04 · Thêm thẻ thành công!',
      subtitle: 'Visa •• 4242 đã đặt làm mặc định.',
      primaryLabel: 'Thanh toán ngay',
      onPrimary: () => Navigator.of(context).pushNamed(RouteNames.samsungPay),
      child: Column(
        children: [
          const SizedBox(height: 16),
          const GradientTick(screen: 4, size: 104),
          const SizedBox(height: AppSpacing.section),
          const PalePill('Mặc định'),
          const SizedBox(height: AppSpacing.section),
          const WhiteCard(
            brand: 'visa',
            last4: '4242',
            cardNumber: '4242 •••• •••• 4242',
            height: 180,
          ),
        ],
      ),
    );
  }
}
