

import 'package:docdoc_app/features/Mood_History/model/MoodRecorrdModel.dart';

abstract class MoodHistoryState {}

class MoodHistoryInitial extends MoodHistoryState {}

class MoodHistoryLoading extends MoodHistoryState {}

class MoodHistoryLoaded extends MoodHistoryState {
  final MoodHistoryResponse moodHistory;

  MoodHistoryLoaded(this.moodHistory);
}

class MoodHistoryError extends MoodHistoryState {
  final String message;

  MoodHistoryError(this.message);
}
