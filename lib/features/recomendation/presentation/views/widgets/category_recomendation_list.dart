import 'package:docdoc_app/core/helpers/assets.dart';
import 'package:docdoc_app/core/widgets/empty_data_widget.dart';
import 'package:docdoc_app/features/recomendation/data/models/recomendation/recomendation_by_category_model.dart';
import 'package:docdoc_app/features/recomendation/presentation/views/widgets/recomendation_card.dart';
import 'package:flutter/material.dart';

class CategoryRecomendationList extends StatelessWidget {
  const CategoryRecomendationList({super.key, required this.recomendations});
  final List<RecomendationByCategoryModel> recomendations;
  @override
  Widget build(BuildContext context) {
    return recomendations.isEmpty
        ? EmptyDataWidget(
          message: 'No recommendation available right now',
          svgAssetPath: Images.imagesImagesNoData,
        )
        : ListView.builder(
          itemCount: recomendations.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: RecomendantionCard(
                titile: recomendations[index].title!,
                diffucltyLevel: recomendations[index].difficultyLevel!,
                discreption: recomendations[index].description!,
                timeRemaining:
                    recomendations[index].estimatedDurationMinutes.toString(),
                instructions: recomendations[index].instructions!,
                ratting: recomendations[index].effectivenessRating.toString(),
              ),
            );
          },
        );
  }
}
