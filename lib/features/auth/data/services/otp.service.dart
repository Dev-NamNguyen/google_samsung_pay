import 'package:google_samsung_pay/core/constants/constants.app.dart';
import 'package:google_samsung_pay/core/data/network/base_api_services.dart';

/// Service OTP — mẫu shopping AuthService: POST qua BaseApiServices,
/// backend thật đã chết nên catch lỗi và xác thực local (demo).
/// Quy tắc demo theo Figma live 27/11: mã đã gửi tới máy là '428516'
/// (6 ô màn 03 hiển thị sẵn 4 2 8 5 1 6) — nhập đúng mã này thì qua,
/// nhập mã khác thì sai và trừ 1 lần thử (màn lỗi 09).
class OtpService {
  final BaseApiServices apiServices;

  OtpService(this.apiServices);

  Future<bool> verifyOtp(String code) async {
    try {
      final res = await apiServices.postApiResponse(
        ConstantsApp.baseUrl + ConstantsApp.otpVerify,
        {'code': code},
      );
      if (res is Map<String, dynamic> && res.containsKey('success')) {
        return res['success'] == true;
      }
    } catch (e) {
      print('⚠️ OtpService.verifyOtp fallback to local: $e');
    }
    return code == '428516';
  }

  void dispose() {}
}
