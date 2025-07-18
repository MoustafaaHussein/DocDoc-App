import 'package:docdoc_app/features/recomendation/data/models/personalize_recomendation_model/personalize_recomendation_model.dart';
import 'package:docdoc_app/features/recomendation/presentation/views/widgets/recomendation_list.dart';
import 'package:flutter/material.dart';

class PresonalizeRecomendationViewBody extends StatelessWidget {
  const PresonalizeRecomendationViewBody({
    super.key,
    required this.personalizeSuggestions,
  });
  final List<PersonalizeRecomendationModel> personalizeSuggestions;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Expanded(
            child: RecomendationList(
              personalizeSuggestions: personalizeSuggestions,
            ),
          ),
        ],
      ),
    );
  }
}
