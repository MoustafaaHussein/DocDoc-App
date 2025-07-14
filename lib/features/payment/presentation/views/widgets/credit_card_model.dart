import 'package:docdoc_app/core/helpers/assets.dart';
import 'package:docdoc_app/core/styles/app_containers_style.dart';
import 'package:docdoc_app/core/styles/app_text_styles.dart';
import 'package:docdoc_app/features/payment/presentation/views/widgets/credit_card_number.dart';
import 'package:docdoc_app/features/payment/presentation/views/widgets/credit_card_type_details.dart';
import 'package:flutter/material.dart';

class CreditCardModel extends StatelessWidget {
  const CreditCardModel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
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
          CreditCardNumber(),
          SizedBox(height: 10),
          Text('AR Jonson', style: AppTextStyles.font13Light),
          SizedBox(height: 15),
          CreditCardTypeDetails(),
        ],
      ),
    );
  }
}
