import 'package:docdoc_app/core/styles/app_containers_style.dart';
import 'package:docdoc_app/core/themes/app_styles.dart';
import 'package:docdoc_app/core/widgets/custom_button.dart';
import 'package:docdoc_app/features/payment/domain/entites/subscription_product_entity/subscription_products.dart';
import 'package:docdoc_app/features/payment/presentation/views/widgets/privacy_terms_view_body.dart';
import 'package:flutter/material.dart';

class PaymentsPlanListViewItems extends StatefulWidget {
  const PaymentsPlanListViewItems({super.key, required this.proPlans});

  final SubscriptionPlan proPlans;

  @override
  State<PaymentsPlanListViewItems> createState() =>
      _PaymentsPlanListViewItemsState();
}

class _PaymentsPlanListViewItemsState extends State<PaymentsPlanListViewItems> {
  bool _isPurchasing = false;

  String get subDuration =>
      widget.proPlans.id.contains("annual")
          ? "annual"
          : widget.proPlans.title.contains("monthly")
          ? "monthly"
          : widget.proPlans.title.contains("sixMonths")
          ? "sixMonths"
          : widget.proPlans.title;

  @override
  Widget build(BuildContext context) {
    final package = widget.proPlans;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Container(
        decoration: AppContainersStyle.proMembershipContainerStyles,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Text(
                  package.title,
                  style: AppStyles.styleMediumLight24(
                    context,
                  ).copyWith(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const SizedBox(height: 30),

              // ---------------- Plan & Price ----------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${package.rawPrice} Plan',
                          style: AppStyles.styleMedium16(
                            context,
                          ).copyWith(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          package.price,
                          style: AppStyles.styleMedium13(
                            context,
                          ).copyWith(color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),

                  // Price text — prefer localized priceString, fallback to numeric to keep your Android look
                  Expanded(
                    child: Text(
                      package.price,
                      style: AppStyles.styleMedium16(
                        context,
                      ).copyWith(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // ---------------- Subscribe Button ----------------
              CustomButton(
                onpressed: () {},
                text: _isPurchasing ? 'Processing…' : 'Subscribe',
                buttonColor:
                    _isPurchasing
                        ? Colors.grey.shade400
                        : const Color(0xffB4D6D9),
              ),

              const SizedBox(height: 12),

              // Restore purchases (required for App Store)
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Restore Purchases",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // ---------------- Footer with Terms & Privacy ----------------
              Center(
                child: TextButton(
                  onPressed: () {
                    // Ensure TermsPrivacyScreen does NOT include any links to pay or web checkouts.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TermsPrivacyScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Terms & Privacy",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
