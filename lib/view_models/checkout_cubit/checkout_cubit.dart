import 'package:animation_project/models/add_to_cart_model.dart';
import 'package:animation_project/models/payment_cart_model.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  void getCartItem() {
    emit(CheckoutLoading());

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

    final PaymentCartModel? chosenPaymentCard =
        dummyPaymentCards.isNotEmpty ? dummyPaymentCards.first : null;

    emit(
      CheckoutLoaded(
        cartItem: cartItem,
        totalAmount: subtotal + 10, // يمكن تعديل الـ 10 حسب الشحن أو الرسوم
        numOfProducts: numOfProducts,
        chosenPaymentCard: chosenPaymentCard,
      ),
    );
  }
}
