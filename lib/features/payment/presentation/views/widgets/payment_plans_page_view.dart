import 'package:docdoc_app/features/payment/presentation/views/widgets/payment_plan_page_view_items.dart';
import 'package:docdoc_app/features/payment/presentation/views/widgets/pro_membership_features_list.dart';
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PaymentsPlansPageView extends StatelessWidget {
  const PaymentsPlansPageView({super.key, required this.proPlans});
  final List<Package> proPlans;

  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: ProMemberShipFeaturesList(),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: proPlans.length,
            itemBuilder: (context, index) {
              return PaymentsPlanListViewItems(proPlans: proPlans[index]);
            },
          ),
        ),
      ],
    );
  }
}
