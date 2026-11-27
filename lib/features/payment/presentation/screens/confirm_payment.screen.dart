import 'package:flutter/material.dart';
import 'package:google_samsung_pay/core/routes/route_names.dart';

import 'package:google_samsung_pay/core/res/colors/colors.app.dart';
import 'package:google_samsung_pay/core/widgets/organisms/card_widgets.dart';
import 'package:google_samsung_pay/core/widgets/molecules/flow_widgets.dart';
import 'package:google_samsung_pay/core/utils/payment.utils.dart';
import 'package:google_samsung_pay/features/payment/presentation/view_model/payment.viewmodel.dart';
import 'package:provider/provider.dart';


// ------------------------------------------------------------------
// 07 — Xác nhận thanh toán — Bước 3/4
// ------------------------------------------------------------------
class ConfirmPaymentScreen extends StatelessWidget {
  const ConfirmPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PaymentViewModel>();
    final order = vm.order;
    return FlowScreen(
      screen: 7,
      step: 3,
      flowLabel: 'Samsung Pay',
      pillLabel: 'SAMSUNG PAY • 3/4',
      title: '07 · Xác nhận thanh toán',
      subtitle: 'Kiểm tra lại thông tin đặt sân trước khi thanh toán.',
      primaryLabel: 'Thanh toán 50.000đ',
      onPrimary: () async {
        final ok = await vm.confirmPayment();
        if (!context.mounted) return;
        if (ok) Navigator.of(context).pushNamed(RouteNames.paymentSuccess);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.cardPadding),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.greyLight),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.sports_tennis, color: AppColors.samsungNavy),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        order.courtFullName,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(order.address,
                    style: TextStyle(color: AppColors.greyText)),
                const Divider(height: 32),
                _billRow('Thời gian', order.dateTime),
                const SizedBox(height: AppSpacing.option),
                _billRow('Số tiền', formatVnd(order.totalCart.totalPrice)),
                const SizedBox(height: AppSpacing.option),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Phí',
                        style: TextStyle(color: AppColors.greyText)),
                    PalePill('Miễn phí', diagonal: true),
                  ],
                ),
                const Divider(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tổng thanh toán',
                        style: TextStyle(fontWeight: FontWeight.w700)),
                    Text(formatVnd(order.payable),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w800)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.section),
          Container(
            padding: const EdgeInsets.all(AppSpacing.cardPadding),
            decoration: BoxDecoration(
              color: AppColors.backgroundAlt,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                VisaLogo(color: Color(0xFF1A1F71), fontSize: 18),
                SizedBox(width: 12),
                Expanded(
                  child: Text('Visa •• ${order.cardLast4}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                ),
                Text('Đổi',
                    style: TextStyle(
                        color: AppColors.blueNeon,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _billRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppColors.greyText)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
