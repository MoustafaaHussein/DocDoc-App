import 'package:docdoc_app/features/Mood_History/cubit/MoodHistoryState.dart';
import 'package:docdoc_app/features/Mood_History/repo/MoodHistoryRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class MoodHistoryCubit extends Cubit<MoodHistoryState> {
  final MoodHistoryRepo repo;

  MoodHistoryCubit(this.repo) : super(MoodHistoryInitial());

  Future<void> fetchMoodHistory() async {
    emit(MoodHistoryLoading());

    final data = await repo.getMoodHistory();
    if (data != null) {
      emit(MoodHistoryLoaded(data));
    } else {
      emit(MoodHistoryError("فشل في تحميل البيانات"));
    }
  }
}
