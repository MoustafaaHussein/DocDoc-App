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
    return Container(
      decoration: AppContainersStyle.proMembershipContainerStyles,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(12),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white),
                borderRadius: BorderRadiusGeometry.circular(12),
              ),
            ),
            child: Text(
              'Premium',
              style: AppStyles.styleSemiBold20(
                context,
              ).copyWith(color: Colors.white),
            ),
          ),
          SizedBox(height: 30),
          Text(
            ' 9\$',
            style: AppStyles.styleSemiBold18(
              context,
            ).copyWith(color: Colors.white),
          ),
          SizedBox(height: 30),
          Text(
            'Write your membership discreption here',
            style: AppStyles.styleMedium13(
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
          SizedBox(height: 50),
          CustomButton(
            onpressed: () {},
            text: 'SubScripe ',
            buttonColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}
