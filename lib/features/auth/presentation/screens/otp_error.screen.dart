import 'package:flutter/material.dart';
import 'package:google_samsung_pay/core/routes/route_names.dart';

import 'package:google_samsung_pay/core/res/colors/colors.app.dart';
import 'package:google_samsung_pay/core/widgets/organisms/card_widgets.dart';
import 'package:google_samsung_pay/core/widgets/molecules/flow_widgets.dart';
import 'package:google_samsung_pay/features/auth/presentation/view_model/otp.viewmodel.dart';
import 'package:provider/provider.dart';


// ------------------------------------------------------------------
// 09 — OTP sai — LỖI OTP • 1/3
// ------------------------------------------------------------------
class ErrorOtpScreen extends StatelessWidget {
  const ErrorOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<OtpViewModel>();
    return FlowScreen(
      screen: 9,
      step: 3,
      flowLabel: 'Đăng ký thẻ',
      title: 'Mã OTP không đúng',
      subtitle: 'Mã bạn nhập không khớp với mã đã gửi. Vui lòng thử lại.',
      pillLabel: 'LỖI OTP • 1/3',
      primaryLabel: 'Nhập lại mã',
      onPrimary: () => Navigator.of(context).pushNamed(RouteNames.otp),
      footer: Column(
        children: [
          const Text('Gửi lại mã sau 00:45',
              style: TextStyle(color: AppColors.greyText)),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Đổi số điện thoại',
              style: TextStyle(
                  color: AppColors.blueNeon, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 8),
          const RedXCircle(size: 96),
          const SizedBox(height: AppSpacing.section),
          // 6 ô OTP đỏ 4 2 8 5 1 6.
          const OtpBoxes(error: true, fixedDigits: '428516'),
          const SizedBox(height: AppSpacing.section),
          Text(
            'Bạn còn ${vm.attemptsLeft} lần thử',
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
