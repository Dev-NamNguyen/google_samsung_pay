import 'package:flutter/material.dart';
import 'package:google_samsung_pay/core/data/response/api_response.dart';
import 'package:google_samsung_pay/features/card_registration/domain/entities/card.entity.dart';
import 'package:google_samsung_pay/features/card_registration/domain/usecases/add_card.usecase.dart';
import 'package:google_samsung_pay/features/card_registration/domain/usecases/get_saved_cards.usecase.dart';

/// ViewModel đăng ký thẻ — mẫu shopping AuthViewModel:
/// ApiResponse<List<CardEntity>> + loading/error, notifyListeners.
class CardViewModel with ChangeNotifier {
  final AddCardUseCase addCardUseCase;
  final GetSavedCardsUseCase getSavedCardsUseCase;

  CardViewModel({
    required this.addCardUseCase,
    required this.getSavedCardsUseCase,
  });

  ApiResponse<List<CardEntity>> savedCards = ApiResponse.loading();
  CardEntity? selectedCard;
  CardEntity? addedCard;
  bool isSubmitting = false;
  String? errorMessage;

  List<CardEntity> get cards => savedCards.data ?? [];

  Future<void> loadSavedCards() async {
    savedCards = ApiResponse.loading();
    notifyListeners();
    try {
      final list = await getSavedCardsUseCase.call();
      savedCards = ApiResponse.completed(list);
      selectedCard ??= list.firstWhere(
        (c) => c.isDefault,
        orElse: () => list.first,
      );
    } catch (e) {
      savedCards = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  void selectCard(CardEntity card) {
    selectedCard = card;
    notifyListeners();
  }

  void setDefault(CardEntity card) {
    selectedCard = card;
    notifyListeners();
  }

  bool get isFormValid =>
      _numberDigits.length >= 15 &&
      _holder.trim().isNotEmpty &&
      _expiry.length >= 5 &&
      _cvv.length >= 3;

  String _numberDigits = '';
  String _holder = '';
  String _expiry = '';
  String _cvv = '';

  void updateForm({
    String? number,
    String? holder,
    String? expiry,
    String? cvv,
  }) {
    if (number != null) _numberDigits = number.replaceAll(RegExp(r'\D'), '');
    if (holder != null) _holder = holder;
    if (expiry != null) _expiry = expiry;
    if (cvv != null) _cvv = cvv;
    notifyListeners();
  }

  String get formNumber => _numberDigits;
  String get formHolder => _holder;
  String get formExpiry => _expiry;
  String get formBrand => _numberDigits.startsWith('5') ? 'mastercard' : 'visa';

  Future<bool> submitAddCard() async {
    isSubmitting = true;
    errorMessage = null;
    notifyListeners();
    try {
      addedCard = await addCardUseCase.call(
        number: _numberDigits,
        holder: _holder,
        expiry: _expiry,
        cvv: _cvv,
      );
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }
}
