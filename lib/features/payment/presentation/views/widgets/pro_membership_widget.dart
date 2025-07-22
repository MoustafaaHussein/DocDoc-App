import 'package:docdoc_app/core/helpers/assets.dart';
import 'package:docdoc_app/core/styles/app_containers_style.dart';
import 'package:docdoc_app/core/themes/app_styles.dart';
import 'package:docdoc_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProMembershipWidget extends StatelessWidget {
  const ProMembershipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: AppContainersStyle.proMembershipContainerStyles,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white),
                    borderRadius: BorderRadiusGeometry.circular(12),
                  ),
                ),
                child: Text(
                  'Premium',
                  style: AppStyles.styleSemiBold24(
                    context,
                  ).copyWith(color: Colors.white),
                ),
              ),
              SizedBox(height: 30),
              Text(
                ' 9\$',
                style: AppStyles.styleSemiBold30(
                  context,
                ).copyWith(color: Colors.white),
              ),
              SizedBox(height: 30),
              Text(
                'Write your membership discreption here',
                style: AppStyles.styleMedium18(
                  context,
                ).copyWith(color: Colors.grey),
              ),
              SizedBox(height: 30),

              Row(
                children: [
                  SvgPicture.asset(Images.imagesImagesTime),
                  SizedBox(width: 4),
                  Text(
                    '30 days',
                    style: AppStyles.styleMedium13(
                      context,
                    ).copyWith(color: Colors.white54),
                  ),
                ],
              ),
              SizedBox(height: 30),
              ProMemberShipFeatures(feature: 'Free Ads and Free Model using'),
              SizedBox(height: 50),
              CustomButton(
                onpressed: () {},
                text: 'SubScripe ',
                buttonColor: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProMemberShipFeatures extends StatelessWidget {
  const ProMemberShipFeatures({super.key, required this.feature});
  final String feature;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(Images.imagesImagesCheckMark),
        SizedBox(width: 10),
        Text(
          feature,
          style: AppStyles.styleMedium16(context).copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
