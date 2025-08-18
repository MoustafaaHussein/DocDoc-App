import 'package:docdoc_app/features/payment/presentation/views/widgets/pro_membership_feature.dart';
import 'package:flutter/material.dart';

class ProMemberShipFeaturesList extends StatelessWidget {
  const ProMemberShipFeaturesList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ProMemberShipFeatures(feature: "ai_face_emotion"),
        SizedBox(height: 8),
        ProMemberShipFeatures(feature: "personalized_recommendations"),
        SizedBox(height: 8),
        ProMemberShipFeatures(feature: "emotion_selection"),
      ],
    );
  }
}
