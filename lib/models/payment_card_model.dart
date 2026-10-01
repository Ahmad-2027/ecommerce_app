class PaymentCardModel {
  final String id;
  final String cardNumber;
  final String cardHolderName;
  final String expiredDate;
  final String cvv;
  final bool isChoosen;

  PaymentCardModel({
    required this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiredDate,
    required this.cvv,
    this.isChoosen = false,
  });

  PaymentCardModel copyWith({
    String? id,
    String? cardNumber,
    String? cardHolderName,
    String? expiredDate,
    String? cvv,
    bool? isChoosen,
  }) {
    return PaymentCardModel(
      id: id ?? this.id,
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      expiredDate: expiredDate ?? this.expiredDate,
      cvv: cvv ?? this.cvv,
      isChoosen: isChoosen ?? this.isChoosen,
    );
  }

  factory PaymentCardModel.fromMap(Map<String, dynamic> map) {
    return PaymentCardModel(
      id: map['id'] as String,
      cardNumber: map['cardNumber'] as String,
      cardHolderName: map['cardHolderName'] as String,
      expiredDate: map['expiredDate'] as String,
      cvv: map['cvv'] as String,
      isChoosen: map['isChoosen'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'cardNumber': cardNumber,
    'cardHolderName': cardHolderName,
    'expiredDate': expiredDate,
    'cvv': cvv,
    'isChoosen': isChoosen,
  };
}

