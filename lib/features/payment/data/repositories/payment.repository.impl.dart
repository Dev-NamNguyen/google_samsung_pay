import 'package:google_samsung_pay/features/payment/data/services/payment.service.dart';
import 'package:google_samsung_pay/features/payment/domain/entities/summary_order.entity.dart';
import 'package:google_samsung_pay/features/payment/domain/repositories/payment.repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentService paymentService;

  PaymentRepositoryImpl({required this.paymentService});

  @override
  Future<SummaryOrderEntity> confirmPayment(SummaryOrderEntity order) =>
      paymentService.confirmPayment(order);
}
