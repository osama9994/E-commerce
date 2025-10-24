// ignore: depend_on_referenced_packages
import 'package:animation_project/models/add_to_cart_model.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';


part 'cart_state.dart';
class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  void getCartItems() async {
    emit(CartLoading());
    emit(CartLoaded(dummyCart, _subtotal));
  }

  void incrementCounter(String productID) {
    final index = dummyCart.indexWhere((item) => item.product.id == productID);

    if (index != -1) {
      final currentItem = dummyCart[index];
      final updatedItem =
          currentItem.copyWith(quantity: currentItem.quantity + 1);
      dummyCart[index] = updatedItem;

      emit(QuantityCounterLoaded(
        productId: productID,
        value: updatedItem.quantity,
      ));

      emit(SubtotalUpdated(_subtotal));
    }
  }

  void decrementCounter(String productID) {
    final index = dummyCart.indexWhere((item) => item.product.id == productID);

    if (index != -1) {
      final currentItem = dummyCart[index];
      if (currentItem.quantity > 1) {
        final updatedItem =
            currentItem.copyWith(quantity: currentItem.quantity - 1);
        dummyCart[index] = updatedItem;

        emit(QuantityCounterLoaded(
          productId: productID,
          value: updatedItem.quantity,
        ));

        emit(SubtotalUpdated(_subtotal));
      }
    }
  }

  double get _subtotal => dummyCart.fold<double>(
        0,
        (previousValue, item) =>
            previousValue + item.product.price * item.quantity,
      );
}
