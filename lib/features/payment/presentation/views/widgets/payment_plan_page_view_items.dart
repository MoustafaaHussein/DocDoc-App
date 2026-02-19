import 'package:docdoc_app/core/helpers/assets.dart';
import 'package:docdoc_app/core/styles/app_containers_style.dart';
import 'package:docdoc_app/core/themes/app_styles.dart';
import 'package:docdoc_app/core/widgets/custom_button.dart';
import 'package:docdoc_app/features/payment/data/models/get_pro_plans/datum.dart';
import 'package:docdoc_app/features/payment/presentation/views/widgets/pro_membership_features_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentsPlanPageViewItems extends StatelessWidget {
  const PaymentsPlanPageViewItems({super.key, required this.proPlans});

  final ProPlans proPlans;

  static final Uri _privacyPolicyUri = Uri.parse(
    'https://github.com/taherfarh/MyMood-PrivacyPolicy/blob/main/Privacy%20Policy',
  );

  static final Uri _termsOfUseUri = Uri.parse(
    'https://www.apple.com/legal/internet-services/itunes/dev/stdeula/',
  );

  Future<void> _openExternalLink(Uri uri) async {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

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
                  proPlans.name!,
                  style: AppStyles.styleSemiBold24(
                    context,
                  ).copyWith(color: Colors.white),
                ),
              ),
              SizedBox(height: 30),
              Text(
                '${proPlans.price} \$',
                style: AppStyles.styleSemiBold30(
                  context,
                ).copyWith(color: Colors.white),
              ),
              SizedBox(height: 30),
              Text(
                proPlans.description!,
                style: AppStyles.styleMedium18(
                  context,
                ).copyWith(color: Colors.grey),
              ),
              SizedBox(height: 30),
              Expanded(
                child: ProMemberShipFeaturesList(features: proPlans.features!),
              ),
              Row(
                children: [
                  SvgPicture.asset(Images.imagesImagesTime),
                  SizedBox(width: 4),
                  Text(
                    '${proPlans.durationDays} days',
                    style: AppStyles.styleMedium13(
                      context,
                    ).copyWith(color: Colors.white54),
                  ),
                ],
              ),
              SizedBox(height: 50),
              CustomButton(
                onpressed: () {},
                text: 'Subscribe',
                buttonColor: Colors.grey,
              ),
              const SizedBox(height: 16),
              Text(
                'DocDoc Pro is an auto-renewable subscription. Your plan lasts '
                'for ${proPlans.durationDays} days and will automatically renew '
                'unless cancelled at least 24 hours before the end of the '
                'current period. You can manage or cancel your subscription in '
                'your App Store account settings.',
                textAlign: TextAlign.center,
                style: AppStyles.styleMedium13(
                  context,
                ).copyWith(color: Colors.white54),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => _openExternalLink(_privacyPolicyUri),
                    child: const Text('Privacy Policy'),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () => _openExternalLink(_termsOfUseUri),
                    child: const Text('Terms of Use'),
                  ),
                ],
              ),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}

