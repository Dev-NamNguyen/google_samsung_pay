import 'package:flutter/material.dart';
import 'package:google_samsung_pay/core/routes/route_names.dart';

import 'package:google_samsung_pay/core/res/colors/colors.app.dart';
import 'package:google_samsung_pay/core/widgets/organisms/card_widgets.dart';
import 'package:google_samsung_pay/core/widgets/molecules/flow_widgets.dart';
import 'package:google_samsung_pay/features/auth/presentation/view_model/otp.viewmodel.dart';
import 'package:provider/provider.dart';


// ------------------------------------------------------------------
// 11 — Vân tay sai — LỖI XÁC THỰC • 3/3
// ------------------------------------------------------------------
class ErrorFingerprintScreen extends StatelessWidget {
  const ErrorFingerprintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<OtpViewModel>();
    return FlowScreen(
      screen: 11,
      step: 2,
      flowLabel: 'Samsung Pay',
      title: 'Xác thực vân tay thất bại',
      // Phụ đề đủ 2 dòng theo audit 25/11.
      subtitle:
          'Vân tay không khớp, còn 2 lần thử. Sau 3 lần sai sẽ chuyển sang nhập mã PIN.',
      pillLabel: 'LỖI XÁC THỰC • 3/3',
      primaryLabel: 'Thử lại vân tay',
      onPrimary: () => Navigator.of(context).pushNamed(RouteNames.samsungPayAuth),
      secondaryLabel: 'Dùng Face ID',
      onSecondary: () => Navigator.of(context).pushNamed(RouteNames.confirmPayment),
      footer: TextButton(
        onPressed: () =>
            Navigator.of(context).pushNamed(RouteNames.confirmPayment),
        child: const Text(
          'Nhập mã PIN thay thế',
          style: TextStyle(
              color: AppColors.blueNeon, fontWeight: FontWeight.w700),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 16),
          // Vân tay đen + badge X đỏ.
          FingerprintView(size: 150, withBadgeX: true),
          SizedBox(height: AppSpacing.section),
          Text(
            'Bạn còn ${vm.fingerprintAttemptsLeft} lần thử',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.errorRed,
            ),
          ),
        ],
      ),
    );
  }
}
