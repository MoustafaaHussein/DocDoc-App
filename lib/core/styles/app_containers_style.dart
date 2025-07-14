import 'package:docdoc_app/core/helpers/assets.dart';
import 'package:flutter/widgets.dart';

abstract class AppContainersStyle {
  static const backButtonStyle = ShapeDecoration(
    color: Color(0xFF1E1E2D),
    shape: OvalBorder(),
  );
  static final creditCardStyle = BoxDecoration(
    color: Color(0xff24243B),
    borderRadius: BorderRadius.circular(20),
    image: DecorationImage(
      fit: BoxFit.fill,
      image: AssetImage(Images.imagesImagesMastercardBackGround),
    ),
  );
}
