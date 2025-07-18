import 'package:docdoc_app/core/helpers/assets.dart';
import 'package:docdoc_app/core/styles/app_containers_style.dart';
import 'package:docdoc_app/core/themes/app_styles.dart';
import 'package:docdoc_app/features/payment/presentation/views/widgets/credit_card_number.dart';
import 'package:docdoc_app/features/payment/presentation/views/widgets/credit_card_type_details.dart';
import 'package:flutter/material.dart';

class CreditCardModel extends StatelessWidget {
  const CreditCardModel({
    super.key,
    required this.creditCardNumber,
    required this.cvc,
    required this.expiryMonth,
    required this.expiryYear,
    required this.cardType,
    required this.cardHolderName,
  });
  final String creditCardNumber,
      cvc,
      expiryMonth,
      expiryYear,
      cardType,
      cardHolderName;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: AppContainersStyle.creditCardStyle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            Images.imagesImagesElectronicChip,
            fit: BoxFit.scaleDown,
            height: 30,
            width: 30,
          ),
          SizedBox(height: 20),
          CreditCardNumber(cardNumber: creditCardNumber),
          SizedBox(height: 10),
          Text(cardHolderName, style: AppStyles.styleRegular14(context)),
          SizedBox(height: 15),
          CreditCardTypeDetails(
            expiryMonth: expiryMonth,
            expiryYear: expiryYear,
            cvc: cvc,
            cardType: cardType,
          ),
        ],
      ),
    );
  }
}
