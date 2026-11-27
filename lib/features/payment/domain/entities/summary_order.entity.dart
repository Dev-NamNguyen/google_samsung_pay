import 'package:google_samsung_pay/features/payment/data/models/total_cart.model.dart';
import 'package:google_samsung_pay/features/payment/domain/entities/payment_method.entity.dart';

/// SummaryOrderEntity — mẫu shopping (domain/entities/summary_order.model):
/// đơn đặt sân + tổng tiền, không phụ thuộc data layer.
class SummaryOrderEntity {
  final String courtName;
  final String court;
  final String address;
  final String dateTime;
  final String bookingCode;
  final TotalCart totalCart;
  final PaymentMethod paymentMethod;
  final String cardLast4;

  const SummaryOrderEntity({
    required this.courtName,
    required this.court,
    required this.address,
    required this.dateTime,
    required this.bookingCode,
    required this.totalCart,
    required this.paymentMethod,
    required this.cardLast4,
  });

  /// Đơn mẫu của Figma màn 7-8: Sân Phú Thọ - Sân 3, 19/11 18:00-19:00,
  /// tổng 50.000đ, Visa •• 4242, mã BDM-20261119-03.
  factory SummaryOrderEntity.demo(TotalCart total) => SummaryOrderEntity(
        courtName: 'Sân Cầu Lông Phú Thọ',
        court: 'Sân 3',
        address: '123 Lý Thường Kiệt, Quận 10',
        dateTime: '19/11 18:00–19:00',
        bookingCode: 'BDM-20261119-03',
        totalCart: total,
        paymentMethod: PaymentMethod.samsungPay,
        cardLast4: '4242',
      );

  String get courtFullName => '$courtName — $court';
  double get payable => totalCart.finalPrice;
}
