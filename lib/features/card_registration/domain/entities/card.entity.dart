/// Entity thẻ đã lưu — domain layer, không phụ thuộc data/framework.
class CardEntity {
  final String id;
  final String brand; // 'visa' | 'mastercard'
  final String last4;
  final String holder;
  final String expiry;
  final bool isDefault;

  const CardEntity({
    required this.id,
    required this.brand,
    required this.last4,
    required this.holder,
    required this.expiry,
    this.isDefault = false,
  });

  String get label => '${brand == 'visa' ? 'Visa' : 'Mastercard'} •• $last4';

  String get maskedNumber =>
      '${last4} •••• •••• ${brand == 'visa' ? '1234' : '5588'}';

  CardEntity copyWith({bool? isDefault}) => CardEntity(
        id: id,
        brand: brand,
        last4: last4,
        holder: holder,
        expiry: expiry,
        isDefault: isDefault ?? this.isDefault,
      );
}
