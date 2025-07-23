import 'package:docdoc_app/core/routes/app_routes.dart';
import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:docdoc_app/features/AiModel/Presentation/views/widgets/submitEmotionButton.dart';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_router/go_router.dart';

class EmotionResultScreen extends StatelessWidget {
  final List<String> labels;
  final List<double> probabilities;
  final VoidCallback onRescan;

  const EmotionResultScreen({
    super.key,
    required this.labels,
    required this.probabilities,
    required this.onRescan,
  });

  @override
  Widget build(BuildContext context) {
    if (probabilities.isEmpty || labels.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("نتيجة التعابير")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "لم يتم التعرف على أي تعبير أو لم يتم تحميل البيانات بشكل صحيح.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onRescan();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "مسح جديد",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    }

    double maxProbability = 0.0;
    String dominantEmotion = "غير معروف";

    for (int i = 0; i < probabilities.length; i++) {
      if (i < labels.length && probabilities[i] > maxProbability) {
        maxProbability = probabilities[i];
        dominantEmotion = labels[i];
      }
    }

    int intensityLevel = ((maxProbability * 10).clamp(1, 10)).round();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.kDarkModeBackgroundColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: Color.fromARGB(180, 215, 215, 231),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                IconlyLight.arrowLeft2,
                color: Color.fromARGB(255, 6, 6, 6),
                size: 25,
              ),
              onPressed: () {
                GoRouter.of(context).pushReplacement(AppRouter.kAiSessionView);
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      "Most Mood",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      dominantEmotion,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "${(maxProbability * 100).toStringAsFixed(2)}%",
                      style: const TextStyle(fontSize: 22, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const Text(
              "All Probabilities",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: labels.length,
                itemBuilder: (context, index) {
                  if (index >= probabilities.length || index >= labels.length) {
                    return const SizedBox.shrink();
                  }
                  final percent = (probabilities[index] * 100).toStringAsFixed(
                    2,
                  );
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 2,
                    child: ListTile(
                      title: Text(
                        labels[index],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Text(
                        "$percent%",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            SubmitEmotionButton(
              emotionType: dominantEmotion,
              intensityLevel: intensityLevel,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onRescan();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Scan Again",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
