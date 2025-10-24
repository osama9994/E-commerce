part of 'checkout_cubit.dart';

@immutable
sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class CheckoutLoading extends CheckoutState {}

final class CheckoutLoaded extends CheckoutState {
  final List<AddToCartModel> cartItem;
  final double totalAmount;
  final int numOfProducts;
  final PaymentCartModel? chosenPaymentCard;
  CheckoutLoaded({
    required this.numOfProducts,
    required this.cartItem,
    required this.totalAmount,
     this.chosenPaymentCard,
  });
}

final class CheckoutError extends CheckoutState {
  final String message;

  CheckoutError({required this.message});
}
