import 'package:camera/camera.dart';
import 'package:image/image.dart' as img_lib;
import 'dart:math' as math;

extension ReshapeList on List {
  List<List<T>> reshape<T>(List<int> shape) {
    if (shape.length != 2) {
      throw ArgumentError('Only 2D reshaping is supported');
    }
    final rows = shape[0];
    final cols = shape[1];
    if (length != rows * cols) {
      throw ArgumentError(
        'Cannot reshape list of length $length into shape $shape. Expected length: ${rows * cols}',
      );
    }
    return [
      for (int i = 0; i < rows; i++)
        sublist(i * cols, (i + 1) * cols).cast<T>(),
    ];
  }
}

// Helper function to convert CameraImage to img_lib.Image (RGB)
img_lib.Image convertYUV420ToImage(CameraImage cameraImage) {
  final width = cameraImage.width;
  final height = cameraImage.height;
  final yBuffer = cameraImage.planes[0].bytes;
  final uBuffer = cameraImage.planes[1].bytes;
  final vBuffer = cameraImage.planes[2].bytes;
  final yRowStride = cameraImage.planes[0].bytesPerRow;
  final uRowStride = cameraImage.planes[1].bytesPerRow;
  final uPixelStride = cameraImage.planes[1].bytesPerPixel!;

  img_lib.Image img = img_lib.Image(width: width, height: height);
  for (int h = 0; h < height; h++) {
    for (int w = 0; w < width; w++) {
      final yIndex = h * yRowStride + w;
      final uvIndex = (h ~/ 2 * uRowStride) + (w ~/ 2 * uPixelStride);
      final y = yBuffer[yIndex];
      final u = uBuffer[uvIndex];
      final v = vBuffer[uvIndex];

      int r = (y + 1.402 * (v - 128)).round();
      int g = (y - 0.344136 * (u - 128) - 0.714136 * (v - 128)).round();
      int b = (y + 1.772 * (u - 128)).round();

      r = math.max(0, math.min(255, r));
      g = math.max(0, math.min(255, g));
      b = math.max(0, math.min(255, b));

      img.setPixelRgb(w, h, r, g, b);
    }
  }
  return img;
}
