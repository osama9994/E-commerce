import 'package:animation_project/models/payment_cart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'payment_method_state.dart';

class PaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  PaymentMethodsCubit() : super(PaymentMethodsInitial());

String selectedPayementId=dummyPaymentCards.first.id;

  void fetchPaymentMethods() {
    emit(FetchingPaymentMethods());

    Future.delayed(const Duration(seconds: 1), () {
      if (dummyPaymentCards.isNotEmpty) {
        final chosenPaymentMethod = dummyPaymentCards.firstWhere(
          (paymentCard) => paymentCard.isChosen,
          orElse: () => dummyPaymentCards.first,
        );

        emit(FetchedPaymentMethods(paymentCards: dummyPaymentCards));
        emit(PaymentMethodChosen(chosenPaymentMethod));
      } else {
        emit(FetchingPaymentMethodsError(errorMessage: "No payment methods found"));
      }
    });
  }


  void changePaymentMethod(String id) {
    selectedPayementId=id;
    
    final tempChosenPaymentMethod =
        dummyPaymentCards.firstWhere((paymentCard) => paymentCard.id == selectedPayementId);
    emit(PaymentMethodChosen(tempChosenPaymentMethod));
  }


  void choosePaymentMethods() {
    emit(FetchingPaymentMethods());

    Future.delayed(const Duration(seconds: 1), () {
      if (dummyPaymentCards.isNotEmpty) {
        emit(FetchedPaymentMethods(paymentCards: dummyPaymentCards));
      } else {
        emit(FetchingPaymentMethodsError(errorMessage: "No payment methods found"));
      }
    });
  }

  
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
        isChosen: false,
      );

      await Future.delayed(const Duration(seconds: 1));

      dummyPaymentCards.add(newCard);

      emit(AddNewCardSuccess());
    } catch (e) {
      emit(AddNewCardFailure(errorMessage: e.toString()));
    }
  }

void confirmPaymentMethod(){
  Future.delayed(
    Duration(seconds: 1),
    (){
      emit(ConfirmPaymentLoading());
final chosenPaymentMethod =
        dummyPaymentCards.firstWhere((paymentCard) => paymentCard.id == selectedPayementId);
    final previousPaymentMethod =
        dummyPaymentCards.firstWhere((paymentCard) => paymentCard.isChosen, orElse: () => chosenPaymentMethod);

 
    final updatedPrevious = previousPaymentMethod.copyWith(isChosen: false);
    final updatedChosen = chosenPaymentMethod.copyWith(isChosen: true);

    
    final indexPrev = dummyPaymentCards.indexOf(previousPaymentMethod);
    final indexChosen = dummyPaymentCards.indexOf(chosenPaymentMethod);

    dummyPaymentCards[indexPrev] = updatedPrevious;
    dummyPaymentCards[indexChosen] = updatedChosen;

    // emit(PaymentMethodChosen(updatedChosen));
    emit(ConfirmPaymentSuccess());
    }
    );
    
}

}
