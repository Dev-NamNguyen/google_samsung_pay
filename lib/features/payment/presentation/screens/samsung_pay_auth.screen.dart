import 'package:flutter/material.dart';
import 'package:google_samsung_pay/core/routes/route_names.dart';

import 'package:google_samsung_pay/core/res/colors/colors.app.dart';
import 'package:google_samsung_pay/core/widgets/organisms/card_widgets.dart';
import 'package:google_samsung_pay/core/widgets/molecules/flow_widgets.dart';


// ------------------------------------------------------------------
// 06 — Xác thực Samsung Pay — Bước 2/4
// ------------------------------------------------------------------
class SamsungAuthScreen extends StatelessWidget {
  const SamsungAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowScreen(
      screen: 6,
      step: 2,
      flowLabel: 'Samsung Pay',
      pillLabel: 'SAMSUNG PAY • 2/4',
      title: '06 · Xác thực Samsung Pay',
      subtitle: 'Chỉ bạn mới có thể xác nhận giao dịch này.',
      primaryLabel: 'Xác thực',
      onPrimary: () => Navigator.of(context).pushNamed(RouteNames.confirmPayment),
      secondaryLabel: 'Dùng mã PIN thay thế',
      onSecondary: () =>
          Navigator.of(context).pushNamed(RouteNames.confirmPayment),
      footer: TextButton(
        onPressed: () => Navigator.of(context).pushNamed(RouteNames.fingerprintError),
        child: const Text(
          'Xem thử màn vân tay sai →',
          style: TextStyle(color: AppColors.errorRed),
        ),
      ),
      child: Column(
        children: [
          // Điện thoại Samsung mờ phía sau + vân tay chi tiết phía trước.
          Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: 0.08,
                child: Container(
                  width: 200,
                  height: 260,
                  decoration: BoxDecoration(
                    color: AppColors.ink,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: AppColors.ink, width: 3),
                  ),
                ),
              ),
              const FingerprintView(size: 150),
            ],
          ),
          const SizedBox(height: AppSpacing.section),
          const Text(
            'Đặt ngón tay lên cảm biến',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.option),
          InkWell(
            onTap: () => Navigator.of(context).pushNamed(RouteNames.confirmPayment),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.cardPadding),
              decoration: BoxDecoration(
                color: AppColors.backgroundAlt,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.greyLight),
              ),
              child: const Row(
                children: [
                  Icon(Icons.face, size: 28, color: AppColors.ink),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Face ID',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600)),
                        Text('Quét khuôn mặt để xác thực',
                            style: TextStyle(
                                fontSize: 12, color: AppColors.greyText)),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios,
                      size: 16, color: AppColors.greyText),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
