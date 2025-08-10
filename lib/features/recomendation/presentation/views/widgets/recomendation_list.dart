import 'package:docdoc_app/core/helpers/assets.dart';
import 'package:docdoc_app/core/widgets/empty_data_widget.dart';
import 'package:docdoc_app/features/recomendation/data/models/personalize_recomendation_model/personalize_recomendation_model.dart';
import 'package:docdoc_app/features/recomendation/presentation/views/widgets/recomendation_card.dart';
import 'package:flutter/material.dart';

class RecomendationList extends StatelessWidget {
  const RecomendationList({super.key, required this.personalizeSuggestions});
  final List<PersonalizeRecomendationModel> personalizeSuggestions;
  @override
  Widget build(BuildContext context) {
    return personalizeSuggestions.isEmpty
        ? const EmptyDataWidget(
          message: 'No recommendation available right now',
          svgAssetPath: Images.imagesImagesNoData,
        )
        : ListView.builder(
          itemCount: personalizeSuggestions.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: RecomendantionCard(
                titile: personalizeSuggestions[index].title!,
                diffucltyLevel: personalizeSuggestions[index].difficultyLevel!,
                discreption: personalizeSuggestions[index].description!,
                timeRemaining:
                    personalizeSuggestions[index].estimatedDurationMinutes
                        .toString(),
                instructions: personalizeSuggestions[index].instructions!,
                ratting:
                    personalizeSuggestions[index].effectivenessRating
                        .toString(),
              ),
            );
          },
        );
  }
}
