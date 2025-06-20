import 'package:docdoc_app/core/helpers/assets.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageMirrorAnimation extends StatelessWidget {
  const ImageMirrorAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      period: const Duration(seconds: 2),
      baseColor: Colors.white,
      highlightColor: Colors.blueGrey,
      child: FittedBox(
        alignment: Alignment.center,
        fit: BoxFit.contain,
        child: SizedBox(
          width: 300,
          height: 300,
          child: Image.asset(Images.imagesImagesSplashScreen),
        ),
      ),
    );
  }
}
