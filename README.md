# Đăng ký thẻ & Samsung Pay — Flutter

Clone Flutter của Figma **'Đăng ký thẻ & Samsung Pay - Trắng Minimal'**
(11 màn, trắng minimal kiểu Apple Pay, gradient volt #CCFF00 -> xanh #00B2FF
khác hướng từng màn, spacing hệ 8pt, padding 24px).
Spec: `~/workspace/samsung-pay-card-flow-spec.md`.

## Kiến trúc — copy mô hình core của shopping (Dev-NamNguyen/shopping, vnb_ban_hang)

- `lib/core/`: constants, data/network (BaseApiServices + NetworkApiServices,
  http, header Bearer từ SessionManager, timeout, responseJson 200/201/400/401),
  data/response (ApiResponse + Status), data/app_exceptions + app_error,
  environment (.env.develop qua flutter_dotenv), routes (RouteNames +
  Routes.generateRoute), res/colors (ColorsBase/ColorsApp — palette đã đổi
  sang trắng minimal, bỏ cam #F36522 / đỏ #BE2728 của shop),
  res/dimensions (hệ 8pt), widgets atoms/molecules/organisms
  (ThemeButton, BorderThemeButton, CompactTextField, BaseScafford,
  LoadingBar, GradientButton, FlowScreen/StepHeader, WhiteCard, OTP, vân tay),
  services/session_manager (singleton, SharedPreferences, token/refresh/user/expiry),
  utils/payment.utils (tính tổng 50.000đ, format VND).
- `lib/features/`: mỗi feature 3 lớp data/domain/presentation, tên file kiểu
  shopping (`*.screen.dart`, `*.provider.dart`, `*.viewmodel.dart`,
  `*.model.dart`, `*.usecase.dart`):
  - `card_registration`: CardModel/CardEntity, AddCardUseCase,
    GetSavedCardsUseCase, CardViewModel/CardProvider (Visa •• 4242 / Mastercard •• 5588).
  - `payment` (Samsung Pay): PaymentMethod enum (card / HOME PayLater / COD /
    samsungPay — lấy từ code thật của shop), SummaryOrderEntity + TotalCart,
    PaymentProvider (Service -> Repository -> UseCase -> ViewModel).
  - `auth`: OtpService + OtpViewModel (6 ô OTP, đếm ngược 00:45, còn 2 lần thử,
    lỗi OTP/thẻ/vân tay), AuthProvider; UserModel/TempUserModel cho SessionManager.
  - `home`: màn danh sách 11 màn (điểm vào điều hướng).
- Không copy UI bán hàng, Firebase/deeplink/notification/AI/video của shopping.
- Backend thật của shop đã chết nên Service nào cũng catch lỗi và trả dữ liệu
  mẫu local — app chạy offline được.

## 11 màn (RouteNames)

Flow 1 đăng ký thẻ: `/payment-method` (01), `/add-card` (02), `/otp` (03),
`/add-card-success` (04). Flow 2 Samsung Pay: `/samsung-pay` (05),
`/samsung-pay-auth` (06), `/confirm-payment` (07), `/payment-success` (08).
Màn lỗi: `/otp-error` (09), `/card-declined` (10), `/fingerprint-error` (11).

## Chạy / kiểm tra

```sh
flutter pub get
flutter analyze
flutter build web
flutter run
```

Nhánh: `feature/samsung-pay-flutter`. Chưa push (GitHub chưa kết nối).
