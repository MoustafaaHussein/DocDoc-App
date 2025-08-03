import 'package:docdoc_app/features/payment/presentation/views/widgets/pro_membership_feature.dart';
import 'package:flutter/material.dart';

class ProMemberShipFeaturesList extends StatelessWidget {
  const ProMemberShipFeaturesList({super.key, required this.features});
  final List<dynamic> features;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: features.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ProMemberShipFeatures(feature: features[index] ?? ''),
        );
      },
    );
  }
}
