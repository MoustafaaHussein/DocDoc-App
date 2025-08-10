import 'package:docdoc_app/core/themes/app_styles.dart';
import 'package:docdoc_app/core/widgets/complete_excersice_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExcersiceDialog extends StatelessWidget {
  const ExcersiceDialog({
    super.key,
    required this.buttonText,
    required this.titleText,
    required this.textColor,
    required this.textIcon,
    this.iconColor,
    required this.onSubmit,
  });
  final String buttonText, titleText;
  final Color textColor;
  final IconData textIcon;
  final Color? iconColor;
  final void Function({required String timeTaken, required String feedback})
  onSubmit;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return CompleteExerciseDialog(
                  onSubmit: onSubmit,
                  onCancel: () {
                    GoRouter.of(context).pop();
                  },
                  titleText: titleText,
                );
              },
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                buttonText,
                style: AppStyles.styleSemiBold18(
                  context,
                ).copyWith(color: textColor),
              ),
              const SizedBox(width: 12),
              Icon(textIcon, color: iconColor ?? Colors.white),
            ],
          ),
        ),
      ],
    );
  }
}
