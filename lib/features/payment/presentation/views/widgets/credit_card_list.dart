import 'package:docdoc_app/features/payment/domain/entites/credit_card_entity.dart';
import 'package:docdoc_app/features/payment/presentation/views/widgets/credit_card_model.dart';
import 'package:flutter/material.dart';

class CreditCardList extends StatelessWidget {
  const CreditCardList({super.key, required this.creditCards});
  final List<CreditCardEntity> creditCards;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: creditCards.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: CreditCardModel(
            creditCardNumber: creditCards[index].cardNumber,
            cvc: creditCards[index].cvc,
            expiryMonth: creditCards[index].expiryMonth,
            expiryYear: creditCards[index].expiryMonth,
            cardType: creditCards[index].cardType,
            cardHolderName: creditCards[index].nameOnCard,
          ),
        );
      },
    );
  }
}
