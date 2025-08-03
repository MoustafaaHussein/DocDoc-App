import 'package:docdoc_app/features/recomendation/data/models/recomendation_by_emoitions_model/recomendation_by_emoitions_model.dart';
import 'package:docdoc_app/features/recomendation/presentation/views/widgets/recomendation_by_emotion_list.dart';
import 'package:flutter/material.dart';

class RecomendationByEmotionsViewBody extends StatelessWidget {
  const RecomendationByEmotionsViewBody({
    super.key,
    required this.recomendations,
  });
  final List<RecomendationByEmoitionsModel> recomendations;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: RecomendationByEmotionList(recomendations: recomendations),
        ),
      ],
    );
  }
}
