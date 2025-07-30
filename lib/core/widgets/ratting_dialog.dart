import 'package:docdoc_app/core/helpers/assets.dart';
import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:docdoc_app/core/themes/app_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RatingDialogWidget extends StatefulWidget {
  final VoidCallback onSubmit;
  final VoidCallback onCancel;
  final String titleText;

  const RatingDialogWidget({
    super.key,
    required this.onSubmit,
    required this.onCancel,
    required this.titleText,
  });

  @override
  State<RatingDialogWidget> createState() => _RatingDialogWidgetState();
}

class _RatingDialogWidgetState extends State<RatingDialogWidget> {
  bool? isHelpful;
  final TextEditingController feedbackController = TextEditingController();

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
                    // Image in the center
                    Container(
                      margin: EdgeInsets.all(12),
                      padding: const EdgeInsets.all(20),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(10),
                        ),
                      ),
                      child: SvgPicture.asset(
                        Images.imagesImagesRatting,
                        height: 100,
                        width: 100,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Title text
                    Text(
                      widget.titleText,
                      style: AppStyles.styleRegular14(
                        context,
                      ).copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 12),

                    // Helpful / Not Helpful Options
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ChoiceChip(
                          label:  Text("helpful".tr()),
                          labelStyle: AppStyles.styleMedium18(context).copyWith(
                            color:
                                isHelpful == true ? Colors.white : Colors.green,
                          ),
                          selected: isHelpful == true,
                          selectedColor: Colors.green,
                          backgroundColor: Colors.transparent,
                          side: BorderSide(color: Colors.green),
                          onSelected: (selected) {
                            setState(() => isHelpful = true);
                          },
                        ),
                        const SizedBox(width: 12),
                        ChoiceChip(
                          label:  Text("not_helpful".tr()),
                          labelStyle: AppStyles.styleMedium18(context).copyWith(
                            color:
                                isHelpful == false ? Colors.white : Colors.red,
                          ),
                          selected: isHelpful == false,
                          selectedColor: Colors.red,
                          backgroundColor: Colors.transparent,
                          side: BorderSide(color: Colors.red),
                          onSelected: (selected) {
                            setState(() => isHelpful = false);
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Feedback TextField
                    TextField(
                      controller: feedbackController,
                      maxLines: 3,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'please_provide_us_with_more_details'.tr(),
                        hintStyle: const TextStyle(color: Color(0xFF98A2B3)),
                        filled: true,
                        fillColor: const Color(0xFF1C1C1E),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.green),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: widget.onSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child:  Text(
                          'submit'.tr(),
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Cancel Icon (X) at top-right
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
