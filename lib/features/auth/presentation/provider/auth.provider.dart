import 'package:provider/provider.dart';
import 'package:google_samsung_pay/core/data/network/base_api_services.dart';
import 'package:google_samsung_pay/features/auth/data/services/otp.service.dart';
import 'package:google_samsung_pay/features/auth/presentation/view_model/otp.viewmodel.dart';

/// Provider auth/OTP — mẫu shopping AuthProvider:
/// Service -> ViewModel (repository/usecase của OTP là service trực tiếp,
/// vì xác thực OTP không có entity riêng).
class AuthProvider {
  static List<dynamic> authProviders = [
    Provider<OtpService>(
      create: (context) => OtpService(context.read<BaseApiServices>()),
      dispose: (context, service) => service.dispose(),
    ),
    ChangeNotifierProvider<OtpViewModel>(
      create: (context) =>
          OtpViewModel(otpService: context.read<OtpService>()),
    ),
  ];
}
