import 'package:google_samsung_pay/features/card_registration/domain/entities/card.entity.dart';

abstract class CardRepository {
  Future<List<CardEntity>> getSavedCards();
  Future<CardEntity> addCard(CardEntity card);
  Future<void> setDefaultCard(String id);
}
