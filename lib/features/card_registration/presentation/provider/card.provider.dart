import 'package:provider/provider.dart';
import 'package:google_samsung_pay/core/data/network/base_api_services.dart';
import 'package:google_samsung_pay/features/card_registration/data/repositories/card.repository.impl.dart';
import 'package:google_samsung_pay/features/card_registration/data/services/card.service.dart';
import 'package:google_samsung_pay/features/card_registration/domain/repositories/card.repository.dart';
import 'package:google_samsung_pay/features/card_registration/domain/usecases/add_card.usecase.dart';
import 'package:google_samsung_pay/features/card_registration/domain/usecases/get_saved_cards.usecase.dart';
import 'package:google_samsung_pay/features/card_registration/presentation/view_model/card.viewmodel.dart';

/// Provider đăng ký thẻ — mẫu shopping PaymentProvider/AuthProvider:
/// Service -> Repository -> UseCase -> ViewModel.
class CardProvider {
  static List<dynamic> cardProviders = [
    Provider<CardService>(
      create: (context) => CardService(context.read<BaseApiServices>()),
      dispose: (context, service) => service.dispose(),
    ),
    Provider<CardRepository>(
      create: (context) =>
          CardRepositoryImpl(cardService: context.read<CardService>()),
    ),
    Provider<AddCardUseCase>(
      create: (context) =>
          AddCardUseCase(repository: context.read<CardRepository>()),
    ),
    Provider<GetSavedCardsUseCase>(
      create: (context) =>
          GetSavedCardsUseCase(repository: context.read<CardRepository>()),
    ),
    ChangeNotifierProvider<CardViewModel>(
      create: (context) => CardViewModel(
        addCardUseCase: context.read<AddCardUseCase>(),
        getSavedCardsUseCase: context.read<GetSavedCardsUseCase>(),
      ),
    ),
  ];
}
