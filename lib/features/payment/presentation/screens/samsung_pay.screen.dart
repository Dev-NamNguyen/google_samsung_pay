import 'package:flutter/material.dart';
import 'package:google_samsung_pay/core/routes/route_names.dart';

import 'package:google_samsung_pay/core/res/colors/colors.app.dart';
import 'package:google_samsung_pay/core/widgets/organisms/card_widgets.dart';
import 'package:google_samsung_pay/core/widgets/molecules/flow_widgets.dart';
import 'package:google_samsung_pay/core/utils/payment.utils.dart';
import 'package:google_samsung_pay/features/payment/presentation/view_model/payment.viewmodel.dart';
import 'package:provider/provider.dart';


// ------------------------------------------------------------------
// 05 — Thanh toán Samsung Pay — Bước 1/4 (flow 2)
// ------------------------------------------------------------------
class SamsungPayScreen extends StatefulWidget {
  const SamsungPayScreen({super.key});

  @override
  State<SamsungPayScreen> createState() => _SamsungPayScreenState();
}

class _SamsungPayScreenState extends State<SamsungPayScreen> {

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PaymentViewModel>();
    final selected = vm.selectedCardLast4 == '4242' ? 'visa' : 'mastercard';
    return FlowScreen(
      screen: 5,
      step: 1,
      flowLabel: 'Samsung Pay',
      pillLabel: 'SAMSUNG PAY • 1/4',
      title: '05 · Thanh toán Samsung Pay',
      subtitle: 'Chọn thẻ trong ví Samsung Pay để thanh toán.',
      primaryLabel: 'Thanh toán 50.000đ',
      onPrimary: () => Navigator.of(context).pushNamed(RouteNames.samsungPayAuth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ví Samsung Pay navy trên nền trắng, viền gradient ngược.
          Container(
            padding: const EdgeInsets.all(AppSpacing.cardPadding),
            decoration: BoxDecoration(
              color: AppColors.samsungNavy,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.blueNeon, width: 2),
              boxShadow: [
                BoxShadow(
                  color: AppColors.samsungNavy.withValues(alpha: 0.25),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'SAMSUNG Pay',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Text('Ví của bạn',
                          style: TextStyle(
                              color: Colors.white, fontSize: 12)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('2 thẻ đã liên kết',
                    style: TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.section),
          const SectionLabel('CHỌN THẺ'),
          const SizedBox(height: AppSpacing.option),
          _cardOption(
            brand: 'visa',
            label: 'Visa •• 4242 (mặc định)',
            sub: 'Mặc định',
            selected: selected == 'visa',
            onTap: () => vm.selectCard('4242'),
          ),
          const SizedBox(height: AppSpacing.option),
          _cardOption(
            brand: 'mastercard',
            label: 'Mastercard •• 5588',
            sub: 'Thẻ phụ',
            selected: selected == 'mastercard',
            onTap: () => vm.selectCard('5588'),
          ),
          const SizedBox(height: AppSpacing.section),
          Container(
            padding: const EdgeInsets.all(AppSpacing.cardPadding),
            decoration: BoxDecoration(
              color: AppColors.backgroundAlt,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Số tiền thanh toán',
                    style: TextStyle(color: AppColors.greyText)),
                Text(formatVnd(vm.order.payable),
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardOption({
    required String brand,
    required String label,
    required String sub,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        decoration: BoxDecoration(
          color: AppColors.backgroundAlt,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AppColors.blueNeon : AppColors.greyLight,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            brand == 'visa'
                ? const VisaLogo(color: Color(0xFF1A1F71), fontSize: 18)
                : const MastercardLogo(size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600)),
                  Text(sub,
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.greyText)),
                ],
              ),
            ),
            if (selected && label.contains('4242'))
              const PalePill('Mặc định'),
            const SizedBox(width: 8),
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: selected ? AppColors.blueNeon : AppColors.greyText,
            ),
          ],
        ),
      ),
    );
  }
}
