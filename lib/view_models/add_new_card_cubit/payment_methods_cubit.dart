import 'package:animation_project/models/payment_cart_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_method_state.dart';


class PaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  PaymentMethodsCubit() : super(PaymentMethodsInitial());


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

void changePaymentMethod(String id){
var chosenPaymentMethod=
dummyPaymentCards.firstWhere((paymentCard)=>paymentCard.id==id);
var previousPaymentMethod=
dummyPaymentCards.firstWhere((paymentCard)=>paymentCard.isChosen==true);
previousPaymentMethod=previousPaymentMethod.copyWith(isChosen: false);
previousPaymentMethod=chosenPaymentMethod.copyWith(isChosen: true);
emit(PaymentMethodChosen(chosenPaymentMethod));


}

}
