import 'package:docdoc_app/core/helpers/assets.dart';
import 'package:docdoc_app/core/styles/app_containers_style.dart';
import 'package:docdoc_app/core/themes/app_styles.dart';
import 'package:docdoc_app/core/widgets/custom_button.dart';
import 'package:docdoc_app/features/payment/data/models/get_pro_plans/datum.dart';
import 'package:docdoc_app/features/payment/presentation/views/widgets/pro_membership_features_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PaymentsPlanPageViewItems extends StatelessWidget {
  const PaymentsPlanPageViewItems({super.key, required this.proPlans});

  final ProPlans proPlans;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Container(
        decoration: AppContainersStyle.proMembershipContainerStyles,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadiusGeometry.circular(12),
                  ),
                ),
                child: Text(
                  proPlans.name!,
                  style: AppStyles.styleSemiBold24(
                    context,
                  ).copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                '${proPlans.price} \$',
                style: AppStyles.styleSemiBold30(
                  context,
                ).copyWith(color: Colors.white),
              ),
              const SizedBox(height: 30),
              Text(
                proPlans.description!,
                style: AppStyles.styleMedium18(
                  context,
                ).copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ProMemberShipFeaturesList(features: proPlans.features!),
              ),
              Row(
                children: [
                  SvgPicture.asset(Images.imagesImagesTime),
                  const SizedBox(width: 4),
                  Text(
                    '${proPlans.durationDays} days',
                    style: AppStyles.styleMedium13(
                      context,
                    ).copyWith(color: Colors.white54),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              CustomButton(
                onpressed: () {},
                text: 'SubScribe ',
                buttonColor: Colors.grey,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
