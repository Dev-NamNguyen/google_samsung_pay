import 'package:flutter/material.dart';
import 'package:google_samsung_pay/core/routes/route_names.dart';
import 'package:flutter/services.dart';

import 'package:google_samsung_pay/core/res/colors/colors.app.dart';
import 'package:google_samsung_pay/core/widgets/organisms/card_widgets.dart';
import 'package:google_samsung_pay/core/widgets/molecules/flow_widgets.dart';
import 'package:google_samsung_pay/features/card_registration/presentation/view_model/card.viewmodel.dart';
import 'package:provider/provider.dart';


// ------------------------------------------------------------------
// 02 — Thêm thẻ mới — Bước 2/4
// ------------------------------------------------------------------
class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _numberCtrl =
      TextEditingController(text: '4242 4242 4242 4242');
  final _nameCtrl = TextEditingController(text: 'SOPHIA');
  final _expiryCtrl = TextEditingController(text: '12/28');
  final _cvvCtrl = TextEditingController();

  String get _displayNumber {
    final digits = _numberCtrl.text.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return '•••• •••• •••• ••••';
    final grouped = <String>[];
    for (var i = 0; i < digits.length; i += 4) {
      grouped.add(digits.substring(
          i, i + 4 > digits.length ? digits.length : i + 4));
    }
    return grouped.join(' ');
  }

  bool get _valid =>
      _numberCtrl.text.replaceAll(RegExp(r'\D'), '').length >= 15 &&
      _nameCtrl.text.trim().isNotEmpty &&
      _expiryCtrl.text.length >= 5 &&
      _cvvCtrl.text.length >= 3;

  @override
  void dispose() {
    _numberCtrl.dispose();
    _nameCtrl.dispose();
    _expiryCtrl.dispose();
    _cvvCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMastercard =
        _numberCtrl.text.replaceAll(RegExp(r'\D'), '').startsWith('5');
    return FlowScreen(
      screen: 2,
      step: 2,
      flowLabel: 'Đăng ký thẻ',
      title: '02 · Thêm thẻ mới',
      subtitle: 'Nhập thông tin thẻ của bạn. Thẻ preview cập nhật theo số gõ vào.',
      primaryLabel: 'Lưu thẻ',
      onPrimary: _valid
          ? () async {
              final vm = context.read<CardViewModel>();
              vm.updateForm(
                number: _numberCtrl.text,
                holder: _nameCtrl.text,
                expiry: _expiryCtrl.text,
                cvv: _cvvCtrl.text,
              );
              final ok = await vm.submitAddCard();
              if (!context.mounted) return;
              if (ok) {
                Navigator.of(context).pushNamed(RouteNames.otp);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(vm.errorMessage ?? 'Thêm thẻ thất bại')),
                );
              }
            }
          : null,
      primaryEnabled: _valid,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WhiteCard(
            brand: isMastercard ? 'mastercard' : 'visa',
            last4: _numberCtrl.text.replaceAll(RegExp(r'\D'), '').length >= 4
                ? _numberCtrl.text
                    .replaceAll(RegExp(r'\D'), '')
                    .substring(
                        _numberCtrl.text.replaceAll(RegExp(r'\D'), '').length -
                            4)
                : '••••',
            cardNumber: _displayNumber,
            holder: _nameCtrl.text.isEmpty
                ? 'SOPHIA'
                : _nameCtrl.text.toUpperCase(),
            expiry:
                _expiryCtrl.text.isEmpty ? 'MM/YY' : _expiryCtrl.text,
          ),
          const SizedBox(height: AppSpacing.section),
          const SectionLabel('SỐ THẺ'),
          const SizedBox(height: 8),
          TextField(
            controller: _numberCtrl,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(16),
              _CardNumberFormatter(),
            ],
            decoration: const InputDecoration(
                hintText: '4242 4242 4242 4242'),
            onChanged: (_) { setState(() {}); context.read<CardViewModel>().updateForm(number: _numberCtrl.text); },
          ),
          const SizedBox(height: AppSpacing.option),
          const SectionLabel('TÊN CHỦ THẺ'),
          const SizedBox(height: 8),
          TextField(
            controller: _nameCtrl,
            textCapitalization: TextCapitalization.characters,
            decoration: const InputDecoration(hintText: 'SOPHIA'),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: AppSpacing.option),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionLabel('NGÀY HẾT HẠN'),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _expiryCtrl,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                        _ExpiryFormatter(),
                      ],
                      decoration:
                          const InputDecoration(hintText: 'MM/YY'),
                      onChanged: (_) => setState(() {}),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.option),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionLabel('CVV'),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _cvvCtrl,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                      decoration: const InputDecoration(hintText: '•••'),
                      onChanged: (_) => setState(() {}),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.section),
          const Row(
            children: [
              Icon(Icons.lock_outline, size: 16, color: AppColors.greyText),
              SizedBox(width: 6),
              Text('Thông tin thẻ được mã hóa an toàn',
                  style: TextStyle(fontSize: 13, color: AppColors.greyText)),
            ],
          ),
        ],
      ),
    );
  }
}

class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final grouped = <String>[];
    for (var i = 0; i < digits.length; i += 4) {
      grouped.add(digits.substring(
          i, i + 4 > digits.length ? digits.length : i + 4));
    }
    return TextEditingValue(
      text: grouped.join(' '),
      selection:
          TextSelection.collapsed(offset: grouped.join(' ').length),
    );
  }
}

class _ExpiryFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final text =
        digits.length > 2 ? '${digits.substring(0, 2)}/${digits.substring(2)}' : digits;
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
