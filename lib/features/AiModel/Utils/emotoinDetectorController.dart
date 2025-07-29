import 'package:camera/camera.dart';
import 'package:docdoc_app/features/AiModel/Model/EmotionData.dart'; // مسار الـ EmotionData
import 'package:docdoc_app/features/AiModel/Utils/EmotionDetector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image/image.dart' as img_lib;
import 'package:tflite_flutter/tflite_flutter.dart';

class EmotionDetectorController {
  CameraController? _cameraController;
  Interpreter? _interpreter;
  List<String> _labels = [];
  List<EmotionData> _emotionProbabilities = [];
  bool _isDetecting = false;
  bool _isModelLoaded = false;
  final int inputImageSize = 48;

  final List<CameraDescription> availableCameras;

  // Callbacks
  VoidCallback? onProbabilitiesUpdate;
  VoidCallback? onInitializationComplete;
  Function(String)? onError; // <--- أضف هذا الـ Callback الجديد

  EmotionDetectorController({required this.availableCameras});

  CameraController? get cameraController => _cameraController;
  List<EmotionData> get emotionProbabilities => _emotionProbabilities;
  bool get isModelLoaded => _isModelLoaded;

  Future<void> initialize() async {
    await _loadModelAndLabels();
    await _initializeCamera();
    onInitializationComplete?.call();
  }

  Future<void> _initializeCamera() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      return;
    }

    if (availableCameras.isEmpty) {
      debugPrint('No cameras available.');
      onError?.call(
        'No cameras found on this device.',
      ); // <--- استخدم الـ callback
      return;
    }

    _cameraController = CameraController(
      availableCameras.length > 1 ? availableCameras[1] : availableCameras[0],
      ResolutionPreset.medium,
      enableAudio: false,
    );

    try {
      await _cameraController!.initialize();
      _startImageStream();
    } on CameraException catch (e) {
      debugPrint("Camera initialization error: $e");
      onError?.call(
        "Failed to initialize camera: ${e.description ?? e.code}",
      ); // <--- استخدم الـ callback
    }
  }

  Future<void> _loadModelAndLabels() async {
    if (_interpreter != null && _labels.isNotEmpty) {
      _isModelLoaded = true;
      return;
    }

    try {
      _interpreter = await Interpreter.fromAsset(' assets/model.tflite');
      final labelsData = await rootBundle.loadString('assets/labels.txt');
      _labels =
          labelsData
              .split('\n')
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toList();
      _isModelLoaded = true;
    } catch (e) {
      debugPrint("Error loading model or labels: $e");
      _isModelLoaded = false;
      onError?.call(
        "Failed to load AI model or labels. Please check assets.",
      ); // <--- استخدم الـ callback
    }
  }

  void _startImageStream() {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }
    if (_cameraController!.value.isStreamingImages) {
      _cameraController!.stopImageStream();
    }
    _cameraController!.startImageStream((CameraImage image) {
      if (!_isDetecting && _isModelLoaded) {
        _isDetecting = true;
        _runInference(image);
      }
    });
  }

  Future<void> stopDetection() async {
    if (_cameraController != null &&
        _cameraController!.value.isStreamingImages) {
      await _cameraController!.stopImageStream();
    }
    _isDetecting = false;
  }

  Future<void> _runInference(CameraImage cameraImage) async {
    if (_interpreter == null || _labels.isEmpty) {
      _isDetecting = false;
      return;
    }

    if (cameraImage.format.group != ImageFormatGroup.yuv420) {
      debugPrint("Unsupported image format: ${cameraImage.format.group}");
      onError?.call(
        "Unsupported camera image format.",
      ); // <--- استخدم الـ callback
      _isDetecting = false;
      return;
    }

    final img_lib.Image img = convertYUV420ToImage(cameraImage);

    final resizedImg = img_lib.copyResize(
      img,
      width: inputImageSize,
      height: inputImageSize,
    );

    var input = List.generate(
      inputImageSize,
      (y) => List.generate(inputImageSize, (x) {
        final pixel = resizedImg.getPixel(x, y);
        return [pixel.r / 255.0, pixel.g / 255.0, pixel.b / 255.0];
      }),
    );

    var output = ReshapeList(
      List.filled(_labels.length, 0.0) as List,
    ).reshape([1, _labels.length]);

    try {
      _interpreter!.run([input], output);
      final List<double> rawProbabilities = output[0].cast<double>();
      _emotionProbabilities =
          List.generate(_labels.length, (index) {
            return EmotionData(_labels[index], rawProbabilities[index]);
          }).toList();

      onProbabilitiesUpdate?.call();
    } catch (e) {
      debugPrint("Error during inference: $e");
      onError?.call(
        "Error processing image for emotion detection.",
      ); // <--- استخدم الـ callback
    } finally {
      _isDetecting = false;
    }
  }

  void dispose() {
    _cameraController?.dispose();
    _interpreter?.close();
  }

  Future<void> resetAndRescan() async {
    _cameraController?.dispose();
    _interpreter?.close();
    _cameraController = null;
    _interpreter = null;
    _isModelLoaded = false;
    _isDetecting = false;
    _emotionProbabilities = [];
    _labels = [];
    await initialize();
    onProbabilitiesUpdate?.call();
  }
}
