import 'package:google_samsung_pay/core/constants/constants.app.dart';
import 'package:google_samsung_pay/core/data/network/base_api_services.dart';
import 'package:google_samsung_pay/features/card_registration/data/models/card.model.dart';

/// Service thẻ — mẫu shopping AuthService: gọi BaseApiServices, catch lỗi
/// thì trả về dữ liệu mẫu (backend thật của shop đã chết).
class CardService {
  final BaseApiServices apiServices;

  CardService(this.apiServices);

  Future<List<CardModel>> getSavedCards() async {
    try {
      final res = await apiServices.getApiResponse(
        ConstantsApp.baseUrl + ConstantsApp.cardList,
      );
      if (res is Map<String, dynamic> && res['data'] is List) {
        return (res['data'] as List)
            .map((e) => CardModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }
    } catch (e) {
      print('⚠️ CardService.getSavedCards fallback to local: $e');
    }
    return CardModel.savedCards;
  }

  Future<CardModel> addCard(CardModel card) async {
    try {
      final res = await apiServices.postApiResponse(
        ConstantsApp.baseUrl + ConstantsApp.cardRegister,
        card.toJson(),
      );
      if (res is Map<String, dynamic> && res['data'] is Map) {
        return CardModel.fromJson(Map<String, dynamic>.from(res['data']));
      }
    } catch (e) {
      print('⚠️ CardService.addCard fallback to local: $e');
    }
    return card;
  }

  void dispose() {}
}
