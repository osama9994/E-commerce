import 'package:animation_project/models/add_to_cart_model.dart';
import 'package:animation_project/models/location_item_model.dart';
import 'package:animation_project/models/payment_cart_model.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  void getCartItem() {
    emit(CheckoutLoading());

    try {
      final cartItem = dummyCart;

      final subtotal = cartItem.fold(
        0.0,
        (previousValue, element) =>
            previousValue + (element.product.price * element.quantity),
      );

      final numOfProducts = cartItem.fold(
        0,
        (previousValue, element) => previousValue + element.quantity,
      );

      PaymentCardModel? chosenPaymentCard;
      LocationItemModel? chosenAddress;

      // 🔒 تحقق من القوائم قبل استخدام first
      if (dummyPaymentCards.isNotEmpty) {
        chosenPaymentCard = dummyPaymentCards.firstWhere(
          (element) => element.isChosen == true,
          orElse: () => dummyPaymentCards.first,
        );
      }

      if (dummyLacations.isNotEmpty) {
        chosenAddress = dummyLacations.firstWhere(
          (element) => element.isChosen == true,
          orElse: () => dummyLacations.first,
        );
      }

      emit(
        CheckoutLoaded(
          cartItem: cartItem,
          totalAmount: subtotal + 10, // رسوم إضافية (مثلاً الشحن)
          numOfProducts: numOfProducts,
          chosenPaymentCard: chosenPaymentCard,
          chosenAddress: chosenAddress,
        ),
      );
    } catch (e) {
      // 🔥 في حال أي خطأ أثناء تحميل البيانات
      emit(CheckoutError(message: e.toString()));
    }
  }
}
