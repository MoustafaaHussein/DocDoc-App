import 'package:flutter/material.dart';

abstract class AppTextStyles {
  static const titile18Normal = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    height: 1,
  );
  static const font24Light = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    height: 1,
  );
  static const font13Light = TextStyle(
    color: Colors.white,
    fontFamily: 'Poppins',
    fontSize: 13,
    fontWeight: FontWeight.w400,
  );
  static const expiryDateTitle9Normal = TextStyle(
    color: Color(0xFFA2A2A7),
    fontSize: 9,

    fontWeight: FontWeight.w400,
  );
  static const expiryDate13Normal = TextStyle(
    color: Colors.white,
    fontSize: 13,

    fontWeight: FontWeight.w400,
  );
}
