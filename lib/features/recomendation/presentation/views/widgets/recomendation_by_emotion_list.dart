import 'package:docdoc_app/core/routes/app_routes.dart';
import 'package:docdoc_app/features/recomendation/data/models/recomendation_by_emoitions_model/recomendation_by_emoitions_model.dart';
import 'package:docdoc_app/features/recomendation/presentation/views/widgets/recomendation_card_minmized.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RecomendationByEmotionList extends StatelessWidget {
  const RecomendationByEmotionList({super.key, required this.recomendations});
  final List<RecomendationByEmoitionsModel> recomendations;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
          child: GestureDetector(
            onTap: () {
              GoRouter.of(context).push(
                AppRouter.kRecomendationByEmotionsDetails,
                extra: recomendations[index],
              );
            },
            child: RecomendationCardMinimized(
              titile: recomendations[index].title!,
              diffucltyLevel: recomendations[index].difficultyLevel!,
              discreption: recomendations[index].description!,
              timeRemaining:
                  recomendations[index].estimatedDurationMinutes.toString(),
              ratting: recomendations[index].effectivenessRating.toString(),
            ),
          ),
        );
      },
      itemCount: recomendations.length,
    );
  }
}
