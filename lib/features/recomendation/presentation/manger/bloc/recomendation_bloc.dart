import 'package:bloc/bloc.dart';
import 'package:docdoc_app/features/recomendation/data/models/personalize_recomendation_model/personalize_recomendation_model.dart';
import 'package:docdoc_app/features/recomendation/data/models/recomendation_by_category_model/recomendation_by_category_model.dart';
import 'package:docdoc_app/features/recomendation/data/models/recomendation_by_emoitions_model/recomendation_by_emoitions_model.dart';
import 'package:docdoc_app/features/recomendation/domain/repos/recomendation_repo.dart';
import 'package:equatable/equatable.dart';

part 'recomendation_event.dart';
part 'recomendation_state.dart';

class RecomendationBloc extends Bloc<RecomendationEvent, RecomendationState> {
  final RecomendationRepo recomendationRepo;
  RecomendationBloc(this.recomendationRepo) : super(RecomendationInitial()) {
    on<RecomendationEvent>((event, emit) async {
      if (event is PersonalizeRecomendationEvent) {
        emit(PersonalizeRecomendationLoading());
        var result = await recomendationRepo.getPersonalizeRecomendation();
        result.fold(
          (failure) {
            return emit(
              PersonalizeRecomendationFailed(
                errorMessage: failure.errorMessage,
              ),
            );
          },
          (recomendations) {
            emit(
              PersonalizeRecomendationSucess(recomendations: recomendations),
            );
          },
        );
      }
      // category recomendation

      if (event is CategoryRecomendationEvent) {
        emit(CategoryRecomendationLoading());
        var result = await recomendationRepo.getRecomendationByCategory(
          subCategory: event.subCategory,
        );
        result.fold(
          (failure) {
            return emit(
              CategoryRecomendationFailed(errorMessage: failure.errorMessage),
            );
          },
          (recomendation) {
            return emit(
              CategoryRecomendationSucess(recomendations: recomendation),
            );
          },
        );
      } else if (event is CompleteExcerciseEvent) {
        emit(CompleteExcerciseLoading());
        var result = await recomendationRepo.completeExcersice(
          excersiceId: event.excersiceId,
          feedBack: event.feedBack,
        );
        result.fold(
          (failure) {
            return emit(
              CompleteExcerciseFailed(errorMessage: failure.errorMessage),
            );
          },
          (sucess) {
            return emit(CompleteExcerciseSuccessful(sucessMessage: sucess));
          },
        );
      } else if (event is GetRecomendationByEmotion) {
        var result = await recomendationRepo.getRecomendationsByEmotions(
          selectedEmotion: event.selectedEmotion,
        );
        result.fold(
          (failure) {
            return emit(
              GetRecomendationBySelectedEmotionFailed(
                errorMessage: failure.errorMessage,
              ),
            );
          },
          (recomendations) {
            return emit(
              GetRecomendationBySelectedEmotionLoaded(
                emotionsRecomendations: recomendations,
              ),
            );
          },
        );
      }
    });
  }
}
