class PaymentCardModel {
  final String id;
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvv;

  PaymentCardModel({
    required this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvv,
  });

 

}

 List<PaymentCardModel>dummyPaymentCards=[

PaymentCardModel(
  id: "1",
   cardNumber: "123 345 5657",
    cardHolderName: "sama alshalbe",
     expiryDate: "12/34",
      cvv: "123",
      ),
PaymentCardModel(
  id: "1",
   cardNumber: "123 3455 557",
    cardHolderName: "osa alshalbe",
     expiryDate: "12/34",
      cvv: "123",
      ),
PaymentCardModel(
  id: "1",
   cardNumber: "123 3455 5657",
    cardHolderName: "osama alshalbe",
     expiryDate: "12/34",
      cvv: "123",
      ),

 ];
