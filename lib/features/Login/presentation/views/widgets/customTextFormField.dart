import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class CustomTextFormField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final IconData? icon;

  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final String hinttext;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.controller,
    this.icon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    required this.hinttext,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool isObscured;

  @override
  void initState() {
    super.initState();
    isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335.w,
      margin: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              color: const Color(0xFFA2A2A7),
              fontSize: 14.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            controller: widget.controller,
            obscureText: isObscured,
            keyboardType: widget.keyboardType,
            validator: widget.validator,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              hintText: widget.hinttext,
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon:
                  widget.icon != null
                      ? Icon(
                        widget.icon,
                        color: const Color(0xFFA2A2A7),
                        size: 20.sp,
                      )
                      : null,

              suffixIcon:
                  widget.obscureText
                      ? IconButton(
                        icon: Icon(
                          isObscured ? IconlyLight.hide : IconlyLight.show,
                          color: const Color(0xFFA2A2A7),
                        ),
                        onPressed: () {
                          setState(() {
                            isObscured = !isObscured;
                          });
                        },
                      )
                      : null,
              filled: true,
              fillColor: const Color(0xFF1E1E1E),
              contentPadding: EdgeInsets.symmetric(
                vertical: 16.h,
                horizontal: 12.w,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Color(0xFF0066FF)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
