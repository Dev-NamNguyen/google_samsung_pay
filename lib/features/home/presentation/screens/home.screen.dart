import 'package:flutter/material.dart';
import 'package:google_samsung_pay/core/routes/route_names.dart';

import 'package:google_samsung_pay/core/res/colors/colors.app.dart';
import 'package:google_samsung_pay/core/widgets/molecules/flow_widgets.dart';

/// Màn danh sách 11 màn — điểm vào điều hướng, không phải màn Figma.
/// Giúp đi đúng thứ tự 01->02->03->04, 05->06->07->08 và mở màn lỗi.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 390),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 56, 24, 24),
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: primaryGradient(1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.sports_tennis,
                    color: Colors.black, size: 32),
              ),
              const SizedBox(height: 16),
              const Text(
                'Đăng ký thẻ &\nSamsung Pay',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    height: 1.2),
              ),
              const SizedBox(height: 8),
              const Text(
                'Trắng Minimal • Apple Pay style\n11 màn — clone từ Figma u2mdm8gccovklfgMDD7bq0',
                style: TextStyle(fontSize: 14, color: AppColors.greyText),
              ),
              const SizedBox(height: 24),
              const SectionLabel('FLOW 1 — ĐĂNG KÝ THẺ'),
              const SizedBox(height: 12),
              _item(context, '01', 'Phương thức thanh toán',
                  'Nút chính: Tiếp tục', RouteNames.paymentMethod, 1),
              _item(context, '02', 'Thêm thẻ mới',
                  'Nút: Lưu thẻ • SOPHIA • 12/28', RouteNames.addCard, 2),
              _item(context, '03', 'Xác thực OTP',
                  '6 ô 4 2 8 5 1 6 • Nút: Xác nhận', RouteNames.otp, 3),
              _item(context, '04', 'Thêm thẻ thành công',
                  'Nút: Thanh toán ngay', RouteNames.addCardSuccess, 4),
              const SizedBox(height: 24),
              const SectionLabel('FLOW 2 — SAMSUNG PAY'),
              const SizedBox(height: 12),
              _item(context, '05', 'Thanh toán Samsung Pay',
                  'Nút: Thanh toán 50.000đ', RouteNames.samsungPay, 5),
              _item(context, '06', 'Xác thực Samsung Pay',
                  'Nút: Xác thực • Vân tay chi tiết', RouteNames.samsungPayAuth, 6),
              _item(context, '07', 'Xác nhận thanh toán',
                  '123 Lý Thường Kiệt, Quận 10 • Nút: Thanh toán 50.000đ', RouteNames.confirmPayment, 7),
              _item(context, '08', 'Thanh toán thành công',
                  'Nút: Xem lịch đặt sân • BDM-20261119-03', RouteNames.paymentSuccess, 8),
              const SizedBox(height: 24),
              const SectionLabel('MÀN LỖI'),
              const SizedBox(height: 12),
              _item(context, '09', 'OTP sai',
                  '6 ô đỏ 4 2 8 5 1 6 • còn 2 lần thử', RouteNames.otpError, 9,
                  isError: true),
              _item(context, '10', 'Thẻ bị từ chối',
                  'Visa mờ 55% • 50.000đ', RouteNames.cardDeclined, 10,
                  isError: true),
              _item(context, '11', 'Vân tay sai',
                  'Vân tay đen + badge X đỏ', RouteNames.fingerprintError, 11,
                  isError: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(BuildContext context, String no, String title, String sub,
      String route, int screen,
      {bool isError = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.backgroundAlt,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.greyLight),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: isError ? null : primaryGradient(screen),
            color: isError ? AppColors.errorRedPale : null,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              no,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: isError ? AppColors.errorRed : AppColors.black,
              ),
            ),
          ),
        ),
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(sub,
            style: const TextStyle(fontSize: 12, color: AppColors.greyText)),
        trailing:
            const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.greyText),
        onTap: () => Navigator.of(context).pushNamed(route),
      ),
    );
  }
}
