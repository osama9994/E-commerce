import 'package:animation_project/models/payment_cart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_method_state.dart';

// Cubit لإدارة البطاقات
class PaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  PaymentMethodsCubit() : super(PaymentMethodsInitial());

  // إضافة بطاقة جديدة
  Future<void> addNewCard(
    String cardNumber,
    String cardHolderName,
    String expiryDate,
    String cvv,
  ) async {
    try {
      emit(AddNewCardLoading());

      final newCard = PaymentCardModel(
        id: DateTime.now().toIso8601String(),
        cardNumber: cardNumber,
        cardHolderName: cardHolderName,
        expiryDate: expiryDate,
        cvv: cvv,
      );

      await Future.delayed(const Duration(seconds: 1));

      dummyPaymentCards.add(newCard);

      emit(AddNewCardSuccess());
    } catch (e) {
      emit(AddNewCardFailure(errorMessage: e.toString()));
    }
  }

  // جلب البطاقات
  void fetchPaymentMethods() {
    emit(FetchingPaymentMethods());

    Future.delayed(const Duration(seconds: 1), () {
      if (dummyPaymentCards.isNotEmpty) {
        emit(FetchedPaymentMethods(paymentCards: dummyPaymentCards));
      } else {
        emit(FetchingPaymentMethodsError(errorMessage: "No payment method found"));
      }
    });
  }
}
