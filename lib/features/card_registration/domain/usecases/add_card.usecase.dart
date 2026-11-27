import 'package:google_samsung_pay/features/card_registration/domain/entities/card.entity.dart';
import 'package:google_samsung_pay/features/card_registration/domain/repositories/card.repository.dart';

/// UseCase đăng ký thẻ — validate số thẻ rồi gọi repository (mẫu shopping).
class AddCardUseCase {
  final CardRepository repository;

  AddCardUseCase({required this.repository});

  Future<CardEntity> call({
    required String number,
    required String holder,
    required String expiry,
    required String cvv,
  }) async {
    final digits = number.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 15) {
      throw ArgumentError('Số thẻ phải đủ 15-16 số');
    }
    if (holder.trim().isEmpty) {
      throw ArgumentError('Chưa nhập tên trên thẻ');
    }
    if (expiry.length < 5) {
      throw ArgumentError('Ngày hết hạn chưa đủ MM/YY');
    }
    if (cvv.length < 3) {
      throw ArgumentError('CVV phải đủ 3-4 số');
    }
    final card = CardEntity(
      id: 'new-${digits.substring(digits.length - 4)}',
      brand: digits.startsWith('5') ? 'mastercard' : 'visa',
      last4: digits.substring(digits.length - 4),
      holder: holder.trim().toUpperCase(),
      expiry: expiry,
    );
    return repository.addCard(card);
  }
}
