import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,

    this.onSaved,
    this.inputType,
    this.onChange,
  });

  final void Function(String?)? onSaved, onChange;

  final TextInputType? inputType;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
        child: TextFormField(
          keyboardType: inputType,
          onSaved: onSaved,
          onChanged: onChange,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This Field is Required';
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }
}
