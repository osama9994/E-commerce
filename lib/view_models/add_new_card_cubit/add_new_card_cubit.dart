

import 'package:animation_project/models/payment_cart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_new_card_state.dart';

class AddNewCardCubit extends Cubit<AddNewCardState> {
  AddNewCardCubit() : super(AddNewCardInitial());

  Future<void> addNewCard(
    String cardNumber,
    String cardHolderName,
    String expiryDate,
    String cvv,
  ) async {
    try {
      emit(AddNewCardLoading());

      // إنشاء الكرت الجديد
      final newCard = PaymentCartModel(
        id: DateTime.now().toIso8601String(),
        cardNumber: cardNumber,
        cardHolderName: cardHolderName,
        expiryDate: expiryDate,
        cvv: cvv,
      );

      // تأخير بسيط لمحاكاة عملية حفظ أو استدعاء API
      await Future.delayed(const Duration(seconds: 1));

      // إضافة البطاقة إلى القائمة التجريبية
      dummyPaymentCards.add(newCard);

      // نجاح العملية
      emit(AddNewCardSuccess());
    } catch (e) {
      // في حال وجود خطأ
      emit(AddNewCardFailure(errorMessage: e.toString()));
    }
  }
}



// import 'package:animation_project/models/payment_cart_model.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';


// part 'add_new_card_state.dart';

// class AddNewCardCubit extends Cubit<AddNewCardState> {
//   AddNewCardCubit() : super(AddNewCardInitial());

// void addNewCard(String cardNumber, String cardHolderName,String expiryDate,String cvv){
//   emit(AddNewCardLoading());
// PaymentCartModel newCard=PaymentCartModel(
//   id: DateTime.now().toIso8601String(),
//   cardNumber: cardNumber,
//   cardHolderName: cardHolderName,
//   expiryDate: expiryDate,
//   cvv: cvv,
//   );
//   Future.delayed(
//    const Duration(seconds: 1),(){
//       dummyPaymentCards.add(newCard);
//       emit(AddNewCardSuccess());
//     }
//   );
// dummyPaymentCards.add(newCard);
//   emit(AddNewCardSuccess());
// }

// }