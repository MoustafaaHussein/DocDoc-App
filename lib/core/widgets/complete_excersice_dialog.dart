import 'package:docdoc_app/core/helpers/assets.dart';
import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:docdoc_app/core/themes/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CompleteExerciseDialog extends StatefulWidget {
  final void Function({required String timeTaken, required String feedback})
  onSubmit;
  final VoidCallback onCancel;
  final String titleText;

  const CompleteExerciseDialog({
    super.key,
    required this.onSubmit,
    required this.onCancel,
    required this.titleText,
  });

  @override
  State<CompleteExerciseDialog> createState() => _CompleteExerciseDialogState();
}

class _CompleteExerciseDialogState extends State<CompleteExerciseDialog> {
  bool? isCompleted;
  final TextEditingController feedbackController = TextEditingController();
  String selectedTime = '5';

  final List<String> timeOptions = [
    '5',
    '10',
    '15',
    '20',
    '25',
    '30',
    '45',
    '60',
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: AppColors.kDarkModeBackgroundColor,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // SVG Image
                    Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.all(20),
                      child: SvgPicture.asset(
                        Images.imagesImagesRatting,
                        height: 100,
                        width: 100,
                        fit: BoxFit.scaleDown,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Title
                    Text(
                      widget.titleText,
                      style: AppStyles.styleRegular14(
                        context,
                      ).copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 12),

                    // Completed / Not Completed
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ChoiceChip(
                          label: const Text("Completed"),
                          labelStyle: AppStyles.styleMedium18(context).copyWith(
                            color:
                                isCompleted == true
                                    ? Colors.white
                                    : Colors.green,
                          ),
                          selected: isCompleted == true,
                          selectedColor: Colors.green,
                          backgroundColor: Colors.transparent,
                          side: const BorderSide(color: Colors.green),
                          onSelected:
                              (selected) => setState(() => isCompleted = true),
                        ),
                        const SizedBox(width: 12),
                        ChoiceChip(
                          label: const Text("Not Completed"),
                          labelStyle: AppStyles.styleMedium18(context).copyWith(
                            color:
                                isCompleted == false
                                    ? Colors.white
                                    : Colors.red,
                          ),
                          selected: isCompleted == false,
                          selectedColor: Colors.red,
                          backgroundColor: Colors.transparent,
                          side: const BorderSide(color: Colors.red),
                          onSelected:
                              (selected) => setState(() => isCompleted = false),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Time taken selector
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1C1E),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedTime,
                        dropdownColor: const Color(0xFF1C1C1E),
                        underline: const SizedBox(),
                        iconEnabledColor: Colors.white,
                        items:
                            timeOptions
                                .map(
                                  (time) => DropdownMenuItem(
                                    value: time,
                                    child: Text(
                                      time,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged:
                            (value) => setState(() => selectedTime = value!),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Feedback field
                    TextField(
                      controller: feedbackController,
                      maxLines: 3,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Please share your thoughts or feedback',
                        hintStyle: const TextStyle(color: Color(0xFF98A2B3)),
                        filled: true,
                        fillColor: const Color(0xFF1C1C1E),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.green),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Submit button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (isCompleted != null) {
                            widget.onSubmit(
                              timeTaken: selectedTime,
                              feedback: feedbackController.text.trim(),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Cancel icon
              Positioned(
                top: 8,
                right: 8,
                child: InkWell(
                  onTap: widget.onCancel,
                  child: const Icon(Icons.close, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
