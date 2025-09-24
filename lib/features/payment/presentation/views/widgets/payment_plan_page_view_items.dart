import 'package:docdoc_app/core/styles/app_containers_style.dart';
import 'package:docdoc_app/core/themes/app_styles.dart';
import 'package:docdoc_app/core/widgets/custom_button.dart';
import 'package:docdoc_app/features/payment/presentation/manger/offering_cubit/offering_cubit.dart';
import 'package:docdoc_app/features/payment/presentation/manger/subscription_cubit/subscription_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PaymentsPlanListViewItems extends StatelessWidget {
  PaymentsPlanListViewItems({super.key, required this.proPlans});

  final Package proPlans;

  String get subDuration =>
      proPlans.identifier.contains("annual")
          ? "annual"
          : proPlans.identifier.contains("monthly")
          ? "monthly"
          : proPlans.identifier.contains("sixMonths")
          ? "sixMonths"
          : proPlans.identifier;

  @override
  Widget build(BuildContext context) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // 👈 align left
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
                          '${getBillingDuration(subDuration)}',
                          style: AppStyles.styleMedium13(
                            context,
                          ).copyWith(color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Text(
                      '${proPlans.storeProduct.currencyCode} ${proPlans.storeProduct.price.toStringAsFixed(2)} / ${getPlanDuration(subDuration)}',
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

              CustomButton(
                onpressed: () {
                  handlePayment(context, proPlans);
                },
                text: 'SubScribe',
                buttonColor: const Color(0xffB4D6D9),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  double calculateSavedAmount({
    required double monthlyPrice,
    required String plan,
    required double planPrice,
  }) {
    switch (plan.toLowerCase()) {
      case "sixmonths":
        double expected = monthlyPrice * 6;
        return expected - planPrice; // saving
      case "annual":
        double expected = monthlyPrice * 12;
        return expected - planPrice;
      case "monthly":
      default:
        return 0.0; // no saving for monthly plan
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
        return "billed every six months"; // fallback in case an unknown value comes
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
        return "6 Months"; // fallback in case an unknown value comes
    }
  }

  handlePayment(BuildContext context, Package package) {
    final offeringCubit = context.read<OfferingCubit>();
    final subscriptionCubit = context.read<SubscriptionCubit>();
    offeringCubit.purchasePackage(package, () {
      subscriptionCubit.checkProStatus();
      subscriptionCubit.stream
          .firstWhere(
            (subState) => subState is SubscriptionLoaded && subState.isPro,
          )
          .then((_) {
            Navigator.pop(context);
          });
    });
    // Implement payment handling logic here
  }
}
