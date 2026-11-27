import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_samsung_pay/core/data/response/api_response.dart';
import 'package:google_samsung_pay/features/auth/data/services/otp.service.dart';

/// OtpViewModel — 6 ô OTP, đếm ngược 00:45, còn 2 lần thử,
/// lỗi OTP / thẻ / vân tay (mẫu shopping AuthViewModel).
class OtpViewModel with ChangeNotifier {
  final OtpService otpService;

  OtpViewModel({required this.otpService});

  static const int maxAttempts = 3;
  static const int resendSeconds = 45;

  // 6 ô OTP hiển thị sẵn mã đã gửi '4 2 8 5 1 6' như Figma màn 03.
  final List<TextEditingController> controllers = List.generate(
    6,
    (i) => TextEditingController(text: '428516'[i]),
  );

  int attemptsLeft = 2;
  int secondsLeft = resendSeconds;
  Timer? _timer;
  ApiResponse<bool> verifyState = ApiResponse.completed(false);

  String get code => controllers.map((c) => c.text).join();
  bool get isComplete => controllers.every((c) => c.text.isNotEmpty);
  bool get canResend => secondsLeft <= 0;

  String get countdown {
    final m = (secondsLeft ~/ 60).toString().padLeft(2, '0');
    final s = (secondsLeft % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void startCountdown() {
    _timer?.cancel();
    secondsLeft = resendSeconds;
    notifyListeners();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (secondsLeft > 0) {
        secondsLeft--;
        notifyListeners();
      } else {
        t.cancel();
      }
    });
  }

  void resend() {
    if (!canResend) return;
    for (final c in controllers) {
      c.clear();
    }
    attemptsLeft = 2;
    startCountdown();
  }

  /// Trả về true nếu OTP đúng; false -> màn lỗi 09, trừ 1 lần thử.
  Future<bool> verify() async {
    if (!isComplete) return false;
    verifyState = ApiResponse.loading();
    notifyListeners();
    final ok = await otpService.verifyOtp(code);
    if (ok) {
      verifyState = ApiResponse.completed(true);
    } else {
      attemptsLeft = attemptsLeft > 0 ? attemptsLeft - 1 : 0;
      verifyState = ApiResponse.error('Mã OTP không đúng');
    }
    notifyListeners();
    return ok;
  }

  // --- Lỗi vân tay màn 11: còn 2 lần thử, sau 3 lần sai -> nhập PIN.
  int fingerprintAttemptsLeft = 2;

  bool fingerprintFailed() {
    fingerprintAttemptsLeft =
        fingerprintAttemptsLeft > 0 ? fingerprintAttemptsLeft - 1 : 0;
    notifyListeners();
    return fingerprintAttemptsLeft > 0;
  }

  void resetFingerprintAttempts() {
    fingerprintAttemptsLeft = 2;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in controllers) {
      c.dispose();
    }
    super.dispose();
  }
}
