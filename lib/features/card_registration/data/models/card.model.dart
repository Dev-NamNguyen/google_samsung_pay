import 'package:google_samsung_pay/features/card_registration/domain/entities/card.entity.dart';

/// Model thẻ — data layer, map JSON <-> Entity (mẫu shopping).
class CardModel extends CardEntity {
  const CardModel({
    required super.id,
    required super.brand,
    required super.last4,
    required super.holder,
    required super.expiry,
    super.isDefault,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id']?.toString() ?? '',
      brand: json['brand']?.toString() ?? 'visa',
      last4: json['last4']?.toString() ?? '',
      holder: json['holder']?.toString() ?? '',
      expiry: json['expiry']?.toString() ?? '',
      isDefault: json['isDefault'] == true,
    );
  }

  factory CardModel.fromEntity(CardEntity e) => CardModel(
        id: e.id,
        brand: e.brand,
        last4: e.last4,
        holder: e.holder,
        expiry: e.expiry,
        isDefault: e.isDefault,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'brand': brand,
        'last4': last4,
        'holder': holder,
        'expiry': expiry,
        'isDefault': isDefault,
      };

  /// Thẻ mẫu của Figma — backend thật đã chết nên service dùng list này.
  static List<CardModel> get savedCards => const [
        CardModel(
          id: 'visa-4242',
          brand: 'visa',
          last4: '4242',
          holder: 'SOPHIA',
          expiry: '12/28',
          isDefault: true,
        ),
        CardModel(
          id: 'mc-5588',
          brand: 'mastercard',
          last4: '5588',
          holder: 'SOPHIA',
          expiry: '06/27',
        ),
      ];
}
