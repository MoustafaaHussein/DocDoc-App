import 'package:docdoc_app/core/styles/app_containers_style.dart';
import 'package:docdoc_app/core/themes/app_styles.dart';
import 'package:docdoc_app/core/widgets/custom_button.dart';
import 'package:docdoc_app/features/payment/presentation/views/widgets/privacy_terms_view_body.dart';
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PaymentsPlanListViewItems extends StatefulWidget {
  const PaymentsPlanListViewItems({super.key, required this.proPlans});

  final Package proPlans;

  @override
  State<PaymentsPlanListViewItems> createState() =>
      _PaymentsPlanListViewItemsState();
}

class _PaymentsPlanListViewItemsState extends State<PaymentsPlanListViewItems> {
  bool _isPurchasing = false;

  String get subDuration =>
      widget.proPlans.identifier.contains("annual")
          ? "annual"
          : widget.proPlans.identifier.contains("monthly")
          ? "monthly"
          : widget.proPlans.identifier.contains("sixMonths")
          ? "sixMonths"
          : widget.proPlans.identifier;

  String _getPriceText(Package package) {
    // Preferred: use the platform-localized price string
    final storeProduct = package.storeProduct;
    // priceString is the localized, formatted price (e.g. $4.99)
    if (storeProduct.priceString.trim().isNotEmpty) {
      return storeProduct.priceString;
    }
    // Fallback: keep the numeric style you used previously (keeps Android look)
    return '${storeProduct.price.toStringAsFixed(2)} / ${getPlanDuration(subDuration)}';
  }

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
                  package.presentedOfferingContext.offeringIdentifier,
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
                          '${getPlanDuration(subDuration)} Plan',
                          style: AppStyles.styleMedium16(
                            context,
                          ).copyWith(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          package.storeProduct.description.isEmpty
                              ? "Enjoy full premium access"
                              : package.storeProduct.description,
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
                      _getPriceText(package),
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
                onpressed: () {
                  // handlePayment(context, package);
                },
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
                  onPressed: () async {
                    try {
                      setState(() => _isPurchasing = true);

                      // RevenueCat restore
                      final customerInfo = await Purchases.restorePurchases();

                      // Refresh subscription state
                      // final subscriptionCubit =
                      //     context.read<SubscriptionCubit>();
                      // await subscriptionCubit.checkProStatus();

                      if (customerInfo.entitlements.all.isNotEmpty &&
                          customerInfo.entitlements.active.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Purchases restored successfully'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('No previous purchases found'),
                          ),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Restore failed: $e')),
                      );
                    } finally {
                      setState(() => _isPurchasing = false);
                    }
                  },
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

  // ---------------- Helper methods ----------------
  double calculateSavedAmount({
    required double monthlyPrice,
    required String plan,
    required double planPrice,
  }) {
    switch (plan.toLowerCase()) {
      case "sixmonths":
        double expected = monthlyPrice * 6;
        return expected - planPrice;
      case "annual":
        double expected = monthlyPrice * 12;
        return expected - planPrice;
      case "monthly":
      default:
        return 0.0;
    }
  }

  String getBillingDuration(String plan) {
    switch (plan.toLowerCase()) {
      case "monthly":
        return "billed monthly";
      case "sixMonths":
        return "billed every six months";
      case "annual":
        return "billed yearly";
      default:
        return "billed every six months";
    }
  }

  String getPlanDuration(String plan) {
    switch (plan.toLowerCase()) {
      case "monthly":
        return "Month";
      case "sixMonths":
        return "6 Months";
      case "annual":
        return "Year";
      default:
        return "6 Months";
    }
  }

  // handlePayment(BuildContext context, Package package) {
  //   final offeringCubit = context.read<OfferingCubit>();
  //   final subscriptionCubit = context.read<SubscriptionCubit>();
  //   offeringCubit.purchasePackage(package, () {
  //     subscriptionCubit.checkProStatus();
  //     subscriptionCubit.stream
  //         .firstWhere(
  //           (subState) => subState is SubscriptionLoaded && subState.isPro,
  //         )
  //         .then((_) {
  //           Navigator.pop(context);
  //         });
  //   });
  // }
}
