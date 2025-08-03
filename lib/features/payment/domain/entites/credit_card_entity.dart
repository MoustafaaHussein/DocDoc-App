class CreditCardEntity {
  final String id;
  final String nameOnCard;
  final String cardNumber;
  final String expiryMonth;
  final String expiryYear;
  final String cvc;
  final String cardType;

  const CreditCardEntity({
    required this.id,
    required this.nameOnCard,
    required this.cardNumber,
    required this.expiryMonth,
    required this.expiryYear,
    required this.cvc,
    required this.cardType,
  });

  factory CreditCardEntity.fromJson(Map<String, dynamic> json) {
    return CreditCardEntity(
      id: json['id'],
      nameOnCard: json['nameOnCard'],
      cardNumber: json['cardNumber'],
      expiryMonth: json['expiryMonth'],
      expiryYear: json['expiryYear'],
      cvc: json['cvc'],
      cardType: json['cardType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameOnCard': nameOnCard,
      'cardNumber': cardNumber,
      'expiryMonth': expiryMonth,
      'expiryYear': expiryYear,
      'cvc': cvc,
      'cardType': cardType,
    };
  }
}
