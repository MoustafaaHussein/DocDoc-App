import 'package:docdoc_app/core/helpers/assets.dart';
import 'package:docdoc_app/core/routes/app_routes.dart';
import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:docdoc_app/core/widgets/custom_app_bar.dart';
import 'package:docdoc_app/core/widgets/custom_button.dart';
import 'package:docdoc_app/core/widgets/empty_data_widget.dart';
import 'package:docdoc_app/features/payment/domain/entites/credit_card_entity.dart';
import 'package:docdoc_app/features/payment/presentation/views/widgets/credit_card_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentViewBody extends StatelessWidget {
  const PaymentViewBody({super.key, required this.creditCards});
  final List<CreditCardEntity> creditCards;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomizedAppBar(
        title: 'All Card',
        onTap: () {
          GoRouter.of(context).pop();
        },
      ),
      body: Column(
        children: [
          creditCards.isNotEmpty
              ? Expanded(child: CreditCardList(creditCards: creditCards))
              : EmptyDataWidget(
                message: 'No Payment Method Added',
                svgAssetPath: Images.imagesImagesNoData,
              ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomButton(
              onpressed: () {
                GoRouter.of(context).push(AppRouter.kAddNewPaymentMethod);
                // showModalBottomSheet(
                //   context: context,
                //   backgroundColor: Colors.transparent,
                //   isScrollControlled: true,
                //   builder:
                //       (context) => FractionallySizedBox(
                //         heightFactor: 0.6,
                //         child: const ProMembershipWidget(),
                //       ),
                // );
              },
              text: "add_card".tr(),
              buttonColor: AppColors.kButtonPrimaryColor,
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
