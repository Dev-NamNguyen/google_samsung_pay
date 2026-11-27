import 'package:google_samsung_pay/features/payment/domain/entities/summary_order.entity.dart';

abstract class PaymentRepository {
  Future<SummaryOrderEntity> confirmPayment(SummaryOrderEntity order);
}
