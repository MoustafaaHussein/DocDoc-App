import 'package:docdoc_app/features/payment/data/models/get_pro_plans/datum.dart';
import 'package:docdoc_app/features/payment/presentation/views/widgets/payment_plan_page_view_items.dart';
import 'package:flutter/material.dart';

class PaymentsPlansPageView extends StatelessWidget {
  const PaymentsPlansPageView({super.key, required this.proPlans});
  final List<ProPlans> proPlans;
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: proPlans.length,
      itemBuilder: (context, index) {
        return PaymentsPlanPageViewItems(proPlans: proPlans[index]);
      },
    );
  }
}
