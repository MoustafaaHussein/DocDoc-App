

import 'package:docdoc_app/features/Analytics/model/AnalyticsModel.dart';

abstract class WeeklyMoodState {}

class WeeklyMoodInitial extends WeeklyMoodState {}

class WeeklyMoodLoading extends WeeklyMoodState {}

class WeeklyMoodLoaded extends WeeklyMoodState {
  final WeeklyMoodModel data;
  WeeklyMoodLoaded(this.data);
}

class WeeklyMoodError extends WeeklyMoodState {
  final String message;
  WeeklyMoodError(this.message);
}
