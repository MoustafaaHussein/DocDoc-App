import 'package:docdoc_app/core/widgets/custom_app_bar.dart';
import 'package:docdoc_app/features/recomendation/data/models/recomendation_by_emoitions_model/recomendation_by_emoitions_model.dart';
import 'package:docdoc_app/features/recomendation/presentation/views/widgets/recomendations_by_emotions_details_body.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RecomendationsByEmotionsDetailsView extends StatelessWidget {
  const RecomendationsByEmotionsDetailsView({
    super.key,
    required this.recomendations,
  });
  final RecomendationByEmoitionsModel recomendations;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomizedAppBar(
        title: '',
        onTap: () {
          GoRouter.of(context).pop();
        },
      ),
      body: RecomendationsByEmotionsDetailsBody(recomendations: recomendations),
    );
  }
}
