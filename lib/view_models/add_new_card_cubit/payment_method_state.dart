part of 'payment_methods_cubit.dart';


sealed class PaymentMethodsState {}

final class PaymentMethodsInitial extends PaymentMethodsState {}
final class AddNewCardLoading extends PaymentMethodsState {}
final class AddNewCardSuccess extends PaymentMethodsState {}
final class AddNewCardFailure extends PaymentMethodsState {
  final String errorMessage;

  AddNewCardFailure({required this.errorMessage});
}

final class FetchingPaymentMethods extends PaymentMethodsState{}
final class FetchedPaymentMethods extends PaymentMethodsState{
  final List<PaymentCardModel>paymentCards;

  FetchedPaymentMethods({required this.paymentCards});


}

final class FetchingPaymentMethodsError extends PaymentMethodsState{
  final String errorMessage;

  FetchingPaymentMethodsError({required this.errorMessage});
}

final class PaymentMethodChosen extends PaymentMethodsState{
  final PaymentCardModel chosenPayment;

  PaymentMethodChosen(this.chosenPayment);
}