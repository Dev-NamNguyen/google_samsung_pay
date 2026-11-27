class ConstantsApp {
  static const String appName = 'Đăng ký thẻ & Samsung Pay';
  static const String packageName = 'com.vnb.googlesamsungpay';
  static const String version = '1.0.0';
  static const String buildNumber = '1';

  // Base URL for API (backend thật của shop đã chết — app này chạy
  // offline với dữ liệu mẫu, service chỉ gọi API khi có backend).
  static const String baseUrl = "https://dev-phuong.shopvnb.com:2704";

  //svg
  static const String logoUrl =
      "https://cdn.shopvnb.com/themes/images/logo.svg";

  // api endpoints
  static const getAllProduct = "/allProducts";
  static const getShoesProducts = "/products";

  // auth endpoints
  static const String authRegister = "/auth/register";
  static const String authLogin = "/auth/login";
  static const String authLogout = "/auth/logout";
  static const String authGetUser = "/auth/user";
  static const String authUpdateUser = "/auth/update-user";
  static const String authChangePassword = "/auth/change-password";
  static const String authDeleteUser = "/auth/delete-user";

  // link image saleoff
  static const String saleOffImageUrl =
      "https://cdn.shopvnb.com/img/406x136/uploads/danh_muc/3_2.webp";
  static const String saleOffImageUrl2 =
      "https://cdn.shopvnb.com/img/406x136/uploads/danh_muc/2.webp";
  static const String saleOffImageUrl3 =
      "https://cdn.shopvnb.com/img/406x136/uploads/danh_muc/1_3.webp";

  // pref keys
  static const String searchHistoryKey = "search_history";
  static const String authTokenKey = "auth_token";
  static const String userDataKey = "user_data";

  // card / samsung pay endpoints (chưa có backend thật)
  static const String cardRegister = "/card/register";
  static const String cardList = "/card/list";
  static const String otpVerify = "/auth/otp/verify";
  static const String samsungPayConfirm = "/samsung-pay/confirm";
}
