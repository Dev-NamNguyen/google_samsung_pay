import 'package:provider/provider.dart';
import 'package:google_samsung_pay/core/data/network/base_api_services.dart';
import 'package:google_samsung_pay/features/payment/data/repositories/payment.repository.impl.dart';
import 'package:google_samsung_pay/features/payment/data/services/payment.service.dart';
import 'package:google_samsung_pay/features/payment/domain/repositories/payment.repository.dart';
import 'package:google_samsung_pay/features/payment/domain/usecases/confirm_payment.usecase.dart';
import 'package:google_samsung_pay/features/payment/presentation/view_model/payment.viewmodel.dart';

/// Provider Samsung Pay — mẫu shopping PaymentProvider:
/// Service -> Repository -> UseCase -> ViewModel.
class PaymentProvider {
  static List<dynamic> paymentProviders = [
    Provider<PaymentService>(
      create: (context) => PaymentService(context.read<BaseApiServices>()),
      dispose: (context, service) => service.dispose(),
    ),
    Provider<PaymentRepository>(
      create: (context) => PaymentRepositoryImpl(
        paymentService: context.read<PaymentService>(),
      ),
    ),
    Provider<ConfirmPaymentUseCase>(
      create: (context) => ConfirmPaymentUseCase(
        repository: context.read<PaymentRepository>(),
      ),
    ),
    ChangeNotifierProvider<PaymentViewModel>(
      create: (context) => PaymentViewModel(
        confirmPaymentUseCase: context.read<ConfirmPaymentUseCase>(),
      ),
    ),
  ];
}
