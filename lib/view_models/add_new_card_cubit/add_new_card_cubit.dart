import 'package:animation_project/models/payment_cart_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


part 'add_new_card_state.dart';

class AddNewCardCubit extends Cubit<AddNewCardState> {
  AddNewCardCubit() : super(AddNewCardInitial());

void addNewCard(String cardNumber, String cardHolderName,String expiryDate,String cvv){
  emit(AddNewCardLoading());
PaymentCartModel newCard=PaymentCartModel(
  id: DateTime.now().toIso8601String(),
  cardNumber: cardNumber,
  cardHolderName: cardHolderName,
  expiryDate: expiryDate,
  cvv: cvv,
  );
  Future.delayed(
   const Duration(seconds: 1),(){
      dummyPaymentCards.add(newCard);
      emit(AddNewCardSuccess());
    }
  );
dummyPaymentCards.add(newCard);
  emit(AddNewCardSuccess());
}

}
