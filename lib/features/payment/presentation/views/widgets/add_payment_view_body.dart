import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:docdoc_app/core/widgets/custom_app_bar.dart';
import 'package:docdoc_app/core/widgets/custom_button.dart';
import 'package:docdoc_app/features/payment/presentation/views/widgets/credit_card_list.dart';
import 'package:flutter/material.dart';

class AddPaymentViewBody extends StatelessWidget {
  const AddPaymentViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomizedAppBar(title: 'All Card', onTap: () {}),
      body: Column(
        children: [
          Expanded(child: CreditCardList()),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CustomButton(
              onpressed: () {},
              text: 'Add Card +',
              buttonColor: AppColors.kButtonPrimaryColor,
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
