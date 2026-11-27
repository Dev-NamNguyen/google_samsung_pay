import 'package:google_samsung_pay/core/constants/constants.app.dart';
import 'package:google_samsung_pay/core/data/network/base_api_services.dart';
import 'package:google_samsung_pay/features/payment/domain/entities/summary_order.entity.dart';

/// Service thanh toán — mẫu shopping: POST qua BaseApiServices,
/// backend thật đã chết nên catch lỗi và trả về đơn demo thành công.
class PaymentService {
  final BaseApiServices apiServices;

  PaymentService(this.apiServices);

  Future<SummaryOrderEntity> confirmPayment(SummaryOrderEntity order) async {
    try {
      await apiServices.postApiResponse(
        ConstantsApp.baseUrl + ConstantsApp.samsungPayConfirm,
        {
          'bookingCode': order.bookingCode,
          'amount': order.payable,
          'cardLast4': order.cardLast4,
          'method': order.paymentMethod.name,
        },
      );
    } catch (e) {
      print('⚠️ PaymentService.confirmPayment fallback to local: $e');
    }
    return order;
  }

  void dispose() {}
}
