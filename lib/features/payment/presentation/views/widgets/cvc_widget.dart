import 'package:docdoc_app/core/styles/app_text_styles.dart';
import 'package:docdoc_app/core/widgets/custom_text_field.dart';
import 'package:flutter/widgets.dart';

class CVC extends StatelessWidget {
  const CVC({super.key, this.onChange});
  final Function(String?)? onChange;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '3 or 4 digits usually\n found on the card back',
          textDirection: TextDirection.ltr,
          style: AppTextStyles.font13Light,
        ),
        const SizedBox(width: 30),
        Expanded(
          child: CustomTextField(
            inputType: TextInputType.numberWithOptions(),

            onChange: onChange,
          ),
        ),
      ],
    );
  }
}
