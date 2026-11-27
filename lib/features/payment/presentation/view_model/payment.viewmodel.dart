import 'package:flutter/material.dart';
import 'package:google_samsung_pay/core/data/response/api_response.dart';
import 'package:google_samsung_pay/core/data/response/status.dart';
import 'package:google_samsung_pay/core/utils/payment.utils.dart';
import 'package:google_samsung_pay/features/payment/domain/entities/payment_method.entity.dart';
import 'package:google_samsung_pay/features/payment/domain/entities/summary_order.entity.dart';
import 'package:google_samsung_pay/features/payment/domain/usecases/confirm_payment.usecase.dart';

/// ViewModel Samsung Pay — mẫu shopping GeocodingViewModel/OrderViewModel:
/// Service -> Repository -> UseCase -> ViewModel, ApiResponse trạng thái.
class PaymentViewModel with ChangeNotifier {
  final ConfirmPaymentUseCase confirmPaymentUseCase;

  PaymentViewModel({required this.confirmPaymentUseCase});

  PaymentMethod _method = PaymentMethod.samsungPay;
  PaymentMethod get method => _method;

  String _selectedCardLast4 = '4242';
  String get selectedCardLast4 => _selectedCardLast4;

  SummaryOrderEntity _order =
      SummaryOrderEntity.demo(totalFinalPayment());
  SummaryOrderEntity get order => _order;

  ApiResponse<SummaryOrderEntity> confirmState =
      ApiResponse.completed(SummaryOrderEntity.demo(totalFinalPayment()));

  bool get isConfirming => confirmState.status == Status.loading;

  void selectMethod(PaymentMethod m) {
    _method = m;
    _order = SummaryOrderEntity(
      courtName: _order.courtName,
      court: _order.court,
      address: _order.address,
      dateTime: _order.dateTime,
      bookingCode: _order.bookingCode,
      totalCart: _order.totalCart,
      paymentMethod: m,
      cardLast4: _selectedCardLast4,
    );
    notifyListeners();
  }

  void selectCard(String last4) {
    _selectedCardLast4 = last4;
    _order = SummaryOrderEntity(
      courtName: _order.courtName,
      court: _order.court,
      address: _order.address,
      dateTime: _order.dateTime,
      bookingCode: _order.bookingCode,
      totalCart: _order.totalCart,
      paymentMethod: _method,
      cardLast4: last4,
    );
    notifyListeners();
  }

  Future<bool> confirmPayment() async {
    confirmState = ApiResponse.loading();
    notifyListeners();
    try {
      final done = await confirmPaymentUseCase.call(_order);
      confirmState = ApiResponse.completed(done);
      notifyListeners();
      return true;
    } catch (e) {
      confirmState = ApiResponse.error(e.toString());
      notifyListeners();
      return false;
    }
  }
}
