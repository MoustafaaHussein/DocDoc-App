import 'package:docdoc_app/features/payment/presentation/views/widgets/credit_card_model.dart';
import 'package:flutter/material.dart';

class CreditCardList extends StatelessWidget {
  const CreditCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: CreditCardModel(),
        );
      },
    );
  }
}
