import 'package:google_samsung_pay/features/payment/domain/entities/summary_order.entity.dart';
import 'package:google_samsung_pay/features/payment/domain/repositories/payment.repository.dart';

class ConfirmPaymentUseCase {
  final PaymentRepository repository;

  ConfirmPaymentUseCase({required this.repository});

  Future<SummaryOrderEntity> call(SummaryOrderEntity order) =>
      repository.confirmPayment(order);
}
