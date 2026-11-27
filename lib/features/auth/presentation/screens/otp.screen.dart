import 'package:flutter/material.dart';
import 'package:google_samsung_pay/core/res/colors/colors.app.dart';
import 'package:google_samsung_pay/core/routes/route_names.dart';
import 'package:google_samsung_pay/core/widgets/molecules/flow_widgets.dart';
import 'package:google_samsung_pay/core/widgets/organisms/card_widgets.dart';
import 'package:google_samsung_pay/features/auth/presentation/view_model/otp.viewmodel.dart';
import 'package:provider/provider.dart';

// ------------------------------------------------------------------
// 03 — Xác thực OTP — Bước 3/4 (dùng OtpViewModel)
// ------------------------------------------------------------------
class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OtpViewModel>().startCountdown();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<OtpViewModel>();
    return FlowScreen(
      screen: 3,
      step: 3,
      flowLabel: 'Đăng ký thẻ',
      title: '03 · Xác thực OTP',
      subtitle: 'Mã xác thực đã được gửi đến •••• 1234.',
      primaryLabel: 'Xác nhận',
      onPrimary: vm.isComplete
          ? () async {
              final navigator = Navigator.of(context);
              final ok = await vm.verify();
              if (!mounted) return;
              navigator.pushNamed(
                  ok ? RouteNames.addCardSuccess : RouteNames.otpError);
            }
          : null,
      primaryEnabled: vm.isComplete,
      footer: TextButton(
        onPressed: () => Navigator.of(context).pushNamed(RouteNames.otpError),
        child: const Text(
          'Xem thử màn OTP sai →',
          style: TextStyle(color: AppColors.errorRed),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 8),
          // 6 ô OTP riêng biệt, to, đều nhau, căn giữa — bắt buộc.
          OtpBoxes(
            controllers: vm.controllers,
            onChanged: (_) => setState(() {}),
            activeIndex:
                vm.controllers.indexWhere((c) => c.text.isEmpty).clamp(0, 5),
          ),
          const SizedBox(height: AppSpacing.section),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.timer_outlined,
                  size: 16, color: AppColors.greyText),
              const SizedBox(width: 6),
              Text(
                vm.secondsLeft > 0
                    ? 'Gửi lại sau ${vm.countdown}'
                    : 'Bạn chưa nhận được mã?',
                style: const TextStyle(color: AppColors.greyText),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: vm.canResend ? () => vm.resend() : null,
                child: Text(
                  'Gửi lại mã',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: vm.canResend
                        ? AppColors.blueNeon
                        : AppColors.greyText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.section),
          Text(
            'Mã gồm 6 số • Còn ${vm.attemptsLeft} lần thử.',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13, color: AppColors.greyText),
          ),
        ],
      ),
    );
  }
}
