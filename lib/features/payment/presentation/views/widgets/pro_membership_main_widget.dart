import 'package:docdoc_app/features/payment/presentation/views/widgets/payment_plans_page_view.dart';
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class ProMemberShipBlocConsumer extends StatelessWidget {
  const ProMemberShipBlocConsumer({super.key, required this.proPlans});
  final List<Package> proPlans;
  @override
  Widget build(BuildContext context) {
    return PaymentsPlansPageView(proPlans: proPlans);
  }
}
