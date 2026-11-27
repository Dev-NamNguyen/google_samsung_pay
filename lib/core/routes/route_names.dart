// RouteNames kiểu shopping — mọi navigation đi qua hằng số này,
// không dùng string literal rải rác trong màn hình.
class RouteNames {
  static const String initial = '/';
  static const String home = '/home';

  // Flow 1 — Đăng ký thẻ (Bước 1/4 -> 4/4)
  static const String paymentMethod = '/payment-method';
  static const String addCard = '/add-card';
  static const String otp = '/otp';
  static const String addCardSuccess = '/add-card-success';

  // Flow 2 — Samsung Pay (Bước 1/4 -> 4/4)
  static const String samsungPay = '/samsung-pay';
  static const String samsungPayAuth = '/samsung-pay-auth';
  static const String confirmPayment = '/confirm-payment';
  static const String paymentSuccess = '/payment-success';

  // Màn lỗi 09-11
  static const String otpError = '/otp-error';
  static const String cardDeclined = '/card-declined';
  static const String fingerprintError = '/fingerprint-error';
}
