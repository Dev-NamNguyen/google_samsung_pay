import 'package:flutter/material.dart';
import 'package:google_samsung_pay/core/routes/route_names.dart';

import 'package:google_samsung_pay/core/res/colors/colors.app.dart';
import 'package:google_samsung_pay/core/widgets/organisms/card_widgets.dart';
import 'package:google_samsung_pay/core/widgets/molecules/flow_widgets.dart';
import 'package:google_samsung_pay/features/card_registration/presentation/view_model/card.viewmodel.dart';
import 'package:provider/provider.dart';


// ------------------------------------------------------------------
// 01 — Phương thức thanh toán — Bước 1/4
// ------------------------------------------------------------------
class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CardViewModel>().loadSavedCards();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Thẻ đã lưu + thẻ đang chọn lấy từ CardViewModel (Service ->
    // Repository -> UseCase -> ViewModel), không hard-code ở màn hình.
    final vm = context.watch<CardViewModel>();
    final selected = vm.selectedCard?.brand ?? 'visa';
    return FlowScreen(
      screen: 1,
      step: 1,
      flowLabel: 'Đăng ký thẻ',
      title: '01 · Phương thức thanh toán',
      subtitle: 'Chọn cách thanh toán phù hợp với bạn.',
      primaryLabel: 'Tiếp tục',
      onPrimary: () => Navigator.of(context).pushNamed(RouteNames.addCard),
      footer: TextButton(
        onPressed: () => Navigator.of(context).pushNamed(RouteNames.samsungPay),
        child: const Text(
          'Thanh toán bằng Samsung Pay →',
          style: TextStyle(
              color: AppColors.samsungNavy, fontWeight: FontWeight.w700),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WhiteCard(brand: 'visa', last4: '4242'),
          const SizedBox(height: AppSpacing.section),
          const SectionLabel('PHƯƠNG THỨC'),
          const SizedBox(height: AppSpacing.option),
          _actionRow(
            icon: Icons.add_card,
            label: 'Thêm thẻ mới',
            onTap: () =>
                Navigator.of(context).pushNamed(RouteNames.addCard),
          ),
          const SizedBox(height: AppSpacing.option),
          _actionRow(
            icon: Icons.phone_android,
            label: 'Samsung Pay',
            onTap: () =>
                Navigator.of(context).pushNamed(RouteNames.samsungPay),
          ),
          const SizedBox(height: AppSpacing.section),
          const SectionLabel('THẺ ĐÃ LƯU'),
          const SizedBox(height: AppSpacing.option),
          ...vm.cards.map((card) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.option),
                child: _methodOption(
                  brand: card.brand,
                  last4: card.last4,
                  label: card.label + (card.isDefault ? ' đã lưu' : ''),
                  isDefault: card.isDefault,
                  selected: selected == card.brand,
                  onTap: () => vm.selectCard(card),
                ),
              )),
          const SizedBox(height: AppSpacing.section),
          Row(
            children: const [
              Icon(Icons.lock_outline, size: 16, color: AppColors.greyText),
              SizedBox(width: 6),
              Text('Được mã hóa • An toàn tuyệt đối',
                  style: TextStyle(fontSize: 13, color: AppColors.greyText)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionRow({
    required IconData icon,
    required String label,
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
          border: Border.all(color: AppColors.greyLight),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.ink),
            const SizedBox(width: 12),
            Expanded(
              child: Text(label,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600)),
            ),
            const Icon(Icons.arrow_forward_ios,
                size: 16, color: AppColors.greyText),
          ],
        ),
      ),
    );
  }

  Widget _methodOption({
    required String brand,
    required String last4,
    required String label,
    bool isDefault = false,
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
          // Viền option đang chọn: gradient (spec 23/11 18:52).
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
              child: Text(label,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600)),
            ),
            if (isDefault) const PalePill('Mặc định'),
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
