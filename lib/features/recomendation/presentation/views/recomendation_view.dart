import 'package:docdoc_app/core/widgets/custom_app_bar.dart';
import 'package:docdoc_app/features/recomendation/presentation/views/widgets/recomendation_view_body.dart';
import 'package:flutter/material.dart';

class RecomendationView extends StatelessWidget {
  const RecomendationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RecomendationViewBody(),
      appBar: CustomizedAppBar(title: 'Choose a Recomendation'),
    );
  }
}
