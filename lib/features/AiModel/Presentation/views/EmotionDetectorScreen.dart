import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:docdoc_app/features/AiModel/Presentation/views/widgets/EmotionResultScreen.dart';
import 'package:docdoc_app/features/AiModel/Utils/EmotionDetector.dart';
import 'package:docdoc_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img_lib show Image, copyResize;
import 'package:tflite_flutter/tflite_flutter.dart';

class EmotionDetectorScreen extends StatefulWidget {
  const EmotionDetectorScreen({super.key});

  @override
  State<EmotionDetectorScreen> createState() => _EmotionDetectorScreenState();
}

class _EmotionDetectorScreenState extends State<EmotionDetectorScreen>
    with WidgetsBindingObserver {
  CameraController? cameraController;
  Interpreter? interpreter;
  List<String> labels = [];
  List<double> emotionProbabilities = [];
  bool isDetecting = false;
  bool _isNavigationInProgress = false;
  final int inputImageSize = 48;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCameraAndModel(); // دالة مجمعة لتهيئة الكاميرا والنموذج
  }

  // دالة مجمعة لتهيئة الكاميرا والنموذج
  Future<void> _initializeCameraAndModel() async {
    await _initializeCamera();
    await _loadModelAndLabels();

    // إعادة تفعيل التنقل التلقائي بعد 7 ثوانٍ
    Future.delayed(const Duration(seconds: 7), () {
      // تم التغيير من 5 إلى 7 ثواني
      if (mounted && !_isNavigationInProgress) {
        _navigateToResultScreen();
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = this.cameraController;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      if (cameraController.value.isStreamingImages) {
        cameraController.stopImageStream();
      }
    } else if (state == AppLifecycleState.resumed) {
      // لا نعيد تشغيل البث هنا إذا كنا نريد إغلاق الكاميرا عند العودة
      // الكاميرا ستُعاد تهيئتها عند الحاجة (إعادة تشغيل المسح)
    }
  }

  Future<void> _initializeCamera() async {
    if (cameraController != null && cameraController!.value.isInitialized) {
      return;
    }

    if (cameras.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('لا توجد كاميرات متاحة.')));
      }
      return;
    }

    cameraController = CameraController(
      cameras.length > 1
          ? cameras[1]
          : cameras[0], // محاولة استخدام الكاميرا الأمامية
      ResolutionPreset.medium,
      enableAudio: false,
    );

    try {
      await cameraController!.initialize();
      if (!mounted) return;
      setState(() {});

      // ابدأ بث الصور فقط إذا لم يكن هناك انتقال قيد التقدم
      // وهذا سيحدث فقط في البداية
      if (!cameraController!.value.isStreamingImages &&
          !_isNavigationInProgress) {
        cameraController!.startImageStream((CameraImage image) {
          if (!isDetecting && mounted && !_isNavigationInProgress) {
            isDetecting = true;
            _runInference(image);
          }
        });
      }
    } on CameraException catch (e) {
      print("خطأ في تهيئة الكاميرا: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ في تهيئة الكاميرا: ${e.description}')),
        );
      }
    }
  }

  Future<void> _loadModelAndLabels() async {
    if (interpreter != null) {
      return;
    }

    try {
      interpreter = await Interpreter.fromAsset('assets/emotions_model.tflite');
      final labelsData = await rootBundle.loadString('assets/labelss.txt');
      labels =
          labelsData
              .split('\n')
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toList();
    } catch (e) {
      print("خطأ في تحميل النموذج أو اللابلز: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('خطأ في تحميل نموذج التعرف على التعابير.'),
          ),
        );
      }
    }
  }

  Future<void> _runInference(CameraImage cameraImage) async {
    if (interpreter == null ||
        labels.isEmpty ||
        !mounted ||
        _isNavigationInProgress) {
      isDetecting = false;
      return;
    }

    if (cameraImage.format.group != ImageFormatGroup.yuv420) {
      print("تنسيق الصورة غير مدعوم: ${cameraImage.format.group}");
      isDetecting = false;
      return;
    }

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
      List.filled(labels.length, 0.0),
    ).reshape([1, labels.length]);

    interpreter!.run([input], output);

    if (mounted && !_isNavigationInProgress) {
      setState(() {
        emotionProbabilities = output[0].cast<double>();
      });
    }

    isDetecting = false;
  }

  void _navigateToResultScreen() async {
    if (!mounted || _isNavigationInProgress) return;

    setState(() {
      _isNavigationInProgress = true;
    });

    // إيقاف بث الكاميرا قبل الانتقال
    try {
      await cameraController?.stopImageStream();
    } on CameraException catch (e) {
      print("خطأ أثناء إيقاف بث الكاميرا: ${e.description}");
    }

    // هنا نقوم بإغلاق الكاميرا والـ Interpreter قبل الانتقال
    // لضمان أنها ليست نشطة عند العودة
    cameraController?.dispose();
    interpreter?.close();
    cameraController = null; // إعادة تعيين لـ null
    interpreter = null; // إعادة تعيين لـ null

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (context) => EmotionResultScreen(
              labels: labels,
              probabilities: emotionProbabilities,
              // تمرير دالة لإعادة تهيئة الشاشة الرئيسية
              onRescan: _resetAndRescan,
            ),
      ),
    );

    // عند العودة من شاشة النتائج، يجب أن تكون الكاميرا والـ interpreter قد أُغلقت
    // ولن نعيد تشغيلها تلقائياً هنا
    if (mounted) {
      setState(() {
        _isNavigationInProgress = false;
        // لا توجد إعادة تشغيل لـ startImageStream هنا
        // لأننا نريد أن تظل الكاميرا مغلقة حتى يضغط المستخدم على "مسح جديد"
      });
    }
  }

  // دالة لإعادة ضبط الحالة وبدء مسح جديد
  void _resetAndRescan() async {
    if (mounted) {
      setState(() {
        emotionProbabilities = []; // مسح النتائج السابقة
        _isNavigationInProgress = false; // التأكد من أن حالة التنقل ليست نشطة
      });
      await _initializeCameraAndModel(); // إعادة تهيئة الكاميرا والنموذج
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // إزالة dispose من هنا لأنها تتم في _navigateToResultScreen
    // cameraController?.dispose();
    // interpreter?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      // إذا لم يتم تهيئة الكاميرا أو كانت في طور الإعداد
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_isNavigationInProgress) {
      return Scaffold(
        appBar: AppBar(title: Text("جاري معالجة النتائج...")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("مسح الوجه...")),
      body: Stack(
        children: [
          CameraPreview(cameraController!),
          if (emotionProbabilities.isNotEmpty && labels.isNotEmpty)
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.black54,
                  child: Text(
                    ' ${labels[emotionProbabilities.indexOf(emotionProbabilities.reduce(math.max))]}: ${(emotionProbabilities.reduce(math.max) * 100).toStringAsFixed(2)}%',
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
