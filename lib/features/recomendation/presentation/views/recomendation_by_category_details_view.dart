import 'package:docdoc_app/core/widgets/custom_app_bar.dart';
import 'package:docdoc_app/features/recomendation/data/models/category_model.dart/category_model.dart';
import 'package:docdoc_app/features/recomendation/presentation/views/widgets/recomendation_by_category_details_view_body.dart';
import 'package:flutter/material.dart';

class RecomendationByCategoryDetailsView extends StatelessWidget {
  const RecomendationByCategoryDetailsView({
    super.key,
    required this.recomendations,
  });
  final RecomendationImageModel recomendations;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomizedAppBar(title: recomendations.recomendation.category!),
      body: RecomendationByCategoryDetailsViewBody(
        recomendations: recomendations.recomendation,
        image: recomendations.recomendationImage,
      ),
    );
  }
}
