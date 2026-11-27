import 'package:google_samsung_pay/features/card_registration/data/models/card.model.dart';
import 'package:google_samsung_pay/features/card_registration/data/services/card.service.dart';
import 'package:google_samsung_pay/features/card_registration/domain/entities/card.entity.dart';
import 'package:google_samsung_pay/features/card_registration/domain/repositories/card.repository.dart';

class CardRepositoryImpl implements CardRepository {
  final CardService cardService;

  CardRepositoryImpl({required this.cardService});

  @override
  Future<List<CardEntity>> getSavedCards() => cardService.getSavedCards();

  @override
  Future<CardEntity> addCard(CardEntity card) async {
    final model = await cardService.addCard(
      CardModel(
        id: 'new-${card.last4}',
        brand: card.brand,
        last4: card.last4,
        holder: card.holder,
        expiry: card.expiry,
      ),
    );
    return model;
  }

  @override
  Future<void> setDefaultCard(String id) async {
    // Chưa có backend thật — đổi mặc định chỉ ở local (ViewModel).
  }
}
