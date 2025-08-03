import 'package:docdoc_app/features/Mood_History/cubit/MoodHistoryState.dart';
import 'package:docdoc_app/features/Mood_History/cubit/MoodeHistoryCubit.dart';
import 'package:docdoc_app/features/Mood_History/repo/MoodHistoryRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class MoodHistoryScreen extends StatelessWidget {
  const MoodHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<MoodHistoryRepo>(
      create: (_) => MoodHistoryRepo(Dio()),
      child: BlocProvider(
        create: (context) => MoodHistoryCubit(
          context.read<MoodHistoryRepo>(),
        )..fetchMoodHistory(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Mood History"),
            centerTitle: true,
          ),
          body: BlocBuilder<MoodHistoryCubit, MoodHistoryState>(
            builder: (context, state) {
              if (state is MoodHistoryLoading) {
                return _buildShimmer();
              } else if (state is MoodHistoryLoaded) {
                final data = state.moodHistory;

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(data.mostCommonEmotion, data.averageIntensity),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          itemCount: data.records.length,
                          itemBuilder: (context, index) {
                            final record = data.records[index];
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: ListTile(
                                leading: Text(
                                  _getEmoji(record.emotionType),
                                  style: const TextStyle(fontSize: 28),
                                ),
                                title: Text(
                                  record.emotionType,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text("Intensity: ${record.intensityLevel}"),
                                trailing: Text(
                                  DateFormat.yMMMMd().add_jm().format(record.recordedAt.toLocal()),
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is MoodHistoryError) {
                return Center(child: Text(state.message));
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }

  /// Shimmer effect while loading
  Widget _buildShimmer() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[800]!,
          highlightColor: Colors.grey[700]!,
          child: Container(
            height: 80,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
    );
  }

  /// Header with most common and average intensity
  Widget _buildHeader(String emotion, double intensity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Most Common Emotion: $emotion",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(
          "Average Intensity: ${intensity.toStringAsFixed(2)}",
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  /// Emoji icon for emotion
  String _getEmoji(String emotion) {
    if (emotion.contains("Happy")) return "😊";
    if (emotion.contains("Sad")) return "😢";
    if (emotion.contains("Angry")) return "😡";
    if (emotion.contains("Neutral")) return "😐";
    if (emotion.contains("Surprised")) return "😲";
    return "🤔";
  }
}
