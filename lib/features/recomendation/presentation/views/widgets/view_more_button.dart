import 'package:docdoc_app/core/themes/app_styles.dart';
import 'package:flutter/material.dart';

class ViewMoreButton extends StatelessWidget {
  const ViewMoreButton({super.key, this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Color(0xff222239)),
      onPressed: onPressed,
      child: Text('View Steps..', style: AppStyles.styleRegular14(context)),
    );
  }
}
