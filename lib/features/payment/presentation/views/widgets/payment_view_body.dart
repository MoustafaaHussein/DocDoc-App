import 'package:docdoc_app/core/routes/app_routes.dart';
import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:docdoc_app/core/widgets/custom_app_bar.dart';
import 'package:docdoc_app/core/widgets/custom_button.dart';
import 'package:docdoc_app/features/payment/presentation/views/widgets/credit_card_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentViewBody extends StatelessWidget {
  const PaymentViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomizedAppBar(title: 'All Card', onTap: () {}),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            Expanded(child: CreditCardList()),
            SizedBox(height: 16),
            CustomButton(
              onpressed: () {
                GoRouter.of(context).push(AppRouter.kAddNewPaymentMethod);
              },
              text: 'Add Card +',
              buttonColor: AppColors.kButtonPrimaryColor,
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
