import 'package:docdoc_app/core/helpers/assets.dart';
import 'package:flutter/material.dart';

abstract class AppContainersStyle {
  static const backButtonStyle = ShapeDecoration(
    color: Color(0xFF1E1E2D),
    shape: OvalBorder(),
  );
  static final creditCardStyle = BoxDecoration(
    color: const Color(0xff24243B),
    borderRadius: BorderRadius.circular(20),
    image: const DecorationImage(
      fit: BoxFit.fill,
      image: AssetImage(Images.imagesImagesMastercardBackGround),
    ),
  );
  static final recomendadtionCardStyle = BoxDecoration(
    color: const Color(0xff24243B),
    borderRadius: BorderRadius.circular(20),
  );
  static final proMembershipContainerStyles = BoxDecoration(
    color: const Color(0xff24243B),
    borderRadius: BorderRadius.circular(20),
  );
}
