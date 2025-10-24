class PaymentCartModel {
  final String id;
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvv;

  PaymentCartModel({
    required this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvv,
  });

 

}

 List<PaymentCartModel>dummyPaymentCards=[];
