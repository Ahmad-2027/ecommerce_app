class AddNewPaymentCardModel {
  final String id;
  final String cardNumber;
  final String cardHolderName;
  final String expiredDate;
  final String cvv;

  AddNewPaymentCardModel({
    required this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiredDate,
    required this.cvv,
  });
}

List<AddNewPaymentCardModel> dumyPaymentCards = [];
