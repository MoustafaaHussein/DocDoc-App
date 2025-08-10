import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreditCardCustomTextField extends StatelessWidget {
  const CreditCardCustomTextField({super.key, this.onSaved, this.onChange});

  final void Function(String?)? onSaved, onChange;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: const Color(0xff24243B),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: TextFormField(
        textAlign: TextAlign.center,
        onChanged: onChange,
        onSaved: onSaved,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This Field is Required';
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(4),
        ],
        decoration: const InputDecoration(border: InputBorder.none),
      ),
    );
  }
}
