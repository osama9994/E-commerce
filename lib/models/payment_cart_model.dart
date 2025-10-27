class PaymentCardModel {
  final String id;
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvv;
  final bool isChosen;

  PaymentCardModel({
    required this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvv,
    this.isChosen = false,
  });

  PaymentCardModel copyWith({
    String? id,
    String? cardNumber,
    String? cardHolderName,
    String? expiryDate,
    String? cvv,
    bool? isChosen,
  }) {
    return PaymentCardModel(
      id: id ?? this.id,
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      expiryDate: expiryDate ?? this.expiryDate,
      cvv: cvv ?? this.cvv,
      isChosen: isChosen ?? this.isChosen,
    );
  }
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
