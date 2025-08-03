import 'dart:math';

import 'package:docdoc_app/core/helpers/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomLoading extends StatefulWidget {
  const CustomLoading({super.key});

  @override
  State<CustomLoading> createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading>
    with TickerProviderStateMixin {
  late final AnimationController _rotationController;
  late final AnimationController _colorController;
  late final Animation<Color?> _colorAnimation;

  final List<Color> _colors = [Colors.red, Colors.green, Colors.yellow];

  @override
  void initState() {
    super.initState();

    // Rotation animation controller
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Color-changing animation controller
    _colorController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    // Color tween sequence (Red → Green → Yellow → Red)
    _colorAnimation = _colorController.drive(
      TweenSequence<Color?>([
        TweenSequenceItem(
          tween: ColorTween(begin: _colors[0], end: _colors[1]),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: ColorTween(begin: _colors[1], end: _colors[2]),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: ColorTween(begin: _colors[2], end: _colors[0]),
          weight: 1,
        ),
      ]),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Rotating arc around the SVG
          AnimatedBuilder(
            animation: Listenable.merge([
              _rotationController,
              _colorController,
            ]),
            builder: (_, __) {
              return Transform.rotate(
                angle: _rotationController.value * 2 * pi,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _colorAnimation.value ?? Colors.red,
                      width: 8,
                    ),
                  ),
                ),
              );
            },
          ),

          // SVG icon in the center (replace the asset path later)
          SvgPicture.asset(
            Images
                .imagesImagesYogaLoadingIndicator, // Replace with your SVG file
            height: 40,
            width: 40,
          ),
        ],
      ),
    );
  }
}
