import 'package:docdoc_app/core/routes/app_routes.dart';
import 'package:docdoc_app/core/styles/TextStyles.dart';
import 'package:docdoc_app/features/AiModel/Presentation/views/widgets/EmotionSubmit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_router/go_router.dart';

class SubmitEmotionButton extends StatelessWidget {
  final String emotionType;
  final int intensityLevel;

  const SubmitEmotionButton({
    super.key,
    required this.emotionType,
    required this.intensityLevel,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        final success = await EmotionSubmitService.submitEmotion(
          emotionType: emotionType,
          intensityLevel: intensityLevel,
        );
        GoRouter.of(
          context,
        ).push(AppRouter.kRecomendationByEmotions, extra: emotionType);
      },
      icon: const Icon(IconlyLight.send),
      label: Text("Submit Emotion", style: Textstyles.font16OWhite700Weight),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
