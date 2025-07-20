// File: lib/core/widgets/empty_data_widget.dart

import 'package:docdoc_app/core/themes/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import for SvgPicture

/// A reusable widget to display a message when there is no data to show.
/// It can be customized with a specific SVG image and a message.
class EmptyDataWidget extends StatelessWidget {
  /// The path to the SVG asset to display.
  final String? svgAssetPath;

  /// The detailed message to display below the SVG.
  final String message;

  /// Optional text style for the message.
  final TextStyle? messageStyle;

  /// Optional height for the SVG image.
  final double svgHeight;

  /// Optional width for the SVG image.
  final double svgWidth;

  const EmptyDataWidget({
    super.key,
    this.svgAssetPath,
    required this.message,
    this.messageStyle,
    this.svgHeight = 120.0, // Default SVG height
    this.svgWidth = 120.0, // Default SVG width
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Display SVG image if provided
            if (svgAssetPath != null) ...[
              SvgPicture.asset(
                svgAssetPath!,
                height: svgHeight,
                width: svgWidth,
                // You might add color or other properties if your SVG needs tinting
                // colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
              ),
              const SizedBox(height: 24.0), // Space between SVG and message
            ],
            // Display the main message
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppStyles.styleMedium18(context),
            ),
          ],
        ),
      ),
    );
  }
}
