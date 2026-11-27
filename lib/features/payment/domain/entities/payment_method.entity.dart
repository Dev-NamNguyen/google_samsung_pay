/// Phương thức thanh toán — lấy từ code thật của shop (Summary Order):
/// card (Visa/Master/JCB), HOME PayLater, COD (mặc định) + Samsung Pay
/// thêm cho flow này.
enum PaymentMethod { card, homePayLater, cod, samsungPay }

extension PaymentMethodLabel on PaymentMethod {
  String get label {
    switch (this) {
      case PaymentMethod.card:
        return 'Thẻ (Visa/Master/JCB)';
      case PaymentMethod.homePayLater:
        return 'HOME PayLater';
      case PaymentMethod.cod:
        return 'COD';
      case PaymentMethod.samsungPay:
        return 'Samsung Pay';
    }
  }
}
