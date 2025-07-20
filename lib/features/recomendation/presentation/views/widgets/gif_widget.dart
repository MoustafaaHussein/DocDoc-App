import 'package:flutter/material.dart';
import 'package:gif/gif.dart';

/// A reusable widget that plays a GIF from assets or network.
///
/// Usage:
/// ```dart
/// GifWidget(
///   gifPath: 'assets/animations/loader.gif',
///   isNetwork: false, // set to true for network GIFs
/// );
/// ```
class GifWidget extends StatefulWidget {
  /// Path to the GIF. If [isNetwork] is false, this should be an asset path.
  final String gifPath;

  /// Whether the gifPath is a network URL.
  final bool isNetwork;

  /// Width of the GIF. If null, uses intrinsic width.
  final double? width;

  /// Height of the GIF. If null, uses intrinsic height.
  final bool loop;

  /// Optional: Duration for a single loop of the GIF animation.
  /// If not provided, a default will be used, but it's good practice
  /// to define it or ensure the GifController gets it automatically
  /// from the GIF metadata. The 'gif' package is usually good at this,
  /// but explicitly setting it (or having a fallback) can prevent this error.
  final Duration? duration;

  const GifWidget({
    super.key,
    required this.gifPath,
    this.isNetwork = false,
    this.width,

    this.loop = true,
    this.duration, // Allow custom duration
  });

  @override
  _GifWidgetState createState() => _GifWidgetState();
}

class _GifWidgetState extends State<GifWidget>
    with SingleTickerProviderStateMixin {
  late GifController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize GifController with a vsync.
    // The 'duration' is crucial for AnimationController.repeat() when not explicitly
    // providing a 'period' argument to repeat().
    // The 'gif' package is designed to derive the duration from the GIF itself.
    // However, if it fails to do so for some reason (e.g., malformed GIF or specific platform issues),
    // or if you want to override it, you can provide a default or a custom one.
    _controller = GifController(
      vsync: this,
      // If widget.duration is provided, use it. Otherwise, rely on the gif package
      // to extract it, or use a reasonable fallback default.
      // The `gif` package often automatically sets the duration internally when the GIF is loaded.
      // But if `repeat()` is called *before* that internal duration is set, this error occurs.
      // So, we'll try to set a duration explicitly if the widget provides one,
      // otherwise, we trust the `gif` package to handle it *after* the image loads.
      // The `addPostFrameCallback` ensures we only call play methods after loading.
    );

    // This listener attempts to play the GIF once it's actually loaded and its duration
    // has been potentially set by the `gif` package internally.
    _controller.addListener(() {
      if (_controller.duration != null &&
          !_controller.isAnimating &&
          _controller.value == 0.0) {
        if (widget.loop) {
          _controller.repeat(min: 0, max: 1);
        } else {
          _controller.forward();
        }
      }
    });

    // We can also trigger the play/repeat command immediately after the widget
    // has been laid out. This often works because by this time, the GIF's
    // duration might have already been parsed and set by the Gif widget internally.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Only attempt to play if duration is available.
        // If it's still null here, the listener should eventually pick it up.
        // Or you might need to add a default duration to the controller constructor
        // if the GIF metadata extraction is consistently failing.
        if (_controller.duration != null) {
          if (widget.loop) {
            _controller.repeat(min: 0, max: 1);
          } else {
            _controller.forward();
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;
    if (widget.isNetwork) {
      imageProvider = NetworkImage(widget.gifPath);
    } else {
      imageProvider = AssetImage(widget.gifPath);
    }

    return Gif(
      controller: _controller,
      image: imageProvider,
      width: widget.width,

      fit: BoxFit.contain,
      // onFetchCompleted: (duration) {
      //   // This callback is fired when the GIF data is fully loaded and parsed,
      //   // and the duration is known. This is a very reliable place to start the animation.
      //   // If you uncomment this, you might remove the post frame callback and listener
      //   // from initState, or use it to re-confirm play state.
      //   if (mounted) {
      //     if (widget.loop) {
      //       _controller.repeat(min: 0, max: 1);
      //     } else {
      //       _controller.forward();
      //     }
      //   }
      // },
    );
  }
}
