import 'package:google_samsung_pay/features/card_registration/domain/entities/card.entity.dart';
import 'package:google_samsung_pay/features/card_registration/domain/repositories/card.repository.dart';

class GetSavedCardsUseCase {
  final CardRepository repository;

  GetSavedCardsUseCase({required this.repository});

  Future<List<CardEntity>> call() => repository.getSavedCards();
}
