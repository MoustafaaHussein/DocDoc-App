import 'package:docdoc_app/features/Analytics/cubit/AnalyticsState.dart';
import 'package:docdoc_app/features/Analytics/repo/AnalyticsRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class WeeklyMoodCubit extends Cubit<WeeklyMoodState> {
  final WeeklyMoodRepo repo;
  WeeklyMoodCubit(this.repo) : super(WeeklyMoodInitial());

  Future<void> fetchWeeklyMood() async {
    emit(WeeklyMoodLoading());
    try {
      final result = await repo.fetchWeeklyMoodAnalysis();
      emit(WeeklyMoodLoaded(result));
    } catch (e) {
      emit(WeeklyMoodError(e.toString()));
    }
  }
}