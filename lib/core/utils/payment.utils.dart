import 'package:google_samsung_pay/features/payment/data/models/total_cart.model.dart';
import 'package:intl/intl.dart';

/// Copy mẫu shopping totalFinalPayment, đổi cho đơn đặt sân:
/// tiền sân 50.000đ, phí dịch vụ 0 (pill "Miễn phí"), không ship, không giảm.
/// Shopping: shippingFee 27000 — ở đây phí sân = 0.
TotalCart totalFinalPayment({double courtFee = 50000}) {
  return TotalCart(
    totalPrice: courtFee,
    totalOriginalPrice: courtFee,
    shippingFee: 0,
    totalDiscountValue: 0,
    quantity: 1,
  );
}

/// Định dạng tiền Việt kiểu shopping (intl): 50000 -> "50.000đ".
String formatVnd(double amount) {
  return '${NumberFormat('#,##0', 'vi_VN').format(amount)}đ';
}

/// Tổng phải trả của SummaryOrder = tiền sân + phí - giảm.
double finalPayable(TotalCart total) => total.finalPrice;
