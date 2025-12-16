import 'package:docdoc_app/features/payment/domain/entites/subscription_product_entity/subscription_products.dart';
import 'package:docdoc_app/features/payment/presentation/views/widgets/payment_plans_page_view.dart';
import 'package:flutter/material.dart';

class ProMemberShipBlocConsumer extends StatelessWidget {
  const ProMemberShipBlocConsumer({super.key, required this.proPlans});
  final List<SubscriptionPlan> proPlans;
  @override
  Widget build(BuildContext context) {
    return PaymentsPlansPageView(proPlans: proPlans);
  }
}
