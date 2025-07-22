part of 'recomendation_bloc.dart';

sealed class RecomendationState extends Equatable {
  const RecomendationState();

  @override
  List<Object> get props => [];
}

final class RecomendationInitial extends RecomendationState {}

final class PersonalizeRecomendationInitial extends RecomendationState {}

final class PersonalizeRecomendationSucess extends RecomendationState {
  final List<PersonalizeRecomendationModel> recomendations;

  const PersonalizeRecomendationSucess({required this.recomendations});
}

final class PersonalizeRecomendationLoading extends RecomendationState {}

final class PersonalizeRecomendationFailed extends RecomendationState {
  final String errorMessage;

  const PersonalizeRecomendationFailed({required this.errorMessage});
}

final class CategoryRecomendationInitial extends RecomendationState {}

final class CategoryRecomendationSucess extends RecomendationState {
  final List<RecomendationByCategoryModel> recomendations;

  const CategoryRecomendationSucess({required this.recomendations});
}

final class CategoryRecomendationLoading extends RecomendationState {}

final class CategoryRecomendationFailed extends RecomendationState {
  final String errorMessage;

  const CategoryRecomendationFailed({required this.errorMessage});
}

final class CompleteExcerciseFailed extends RecomendationState {
  final String errorMessage;

  const CompleteExcerciseFailed({required this.errorMessage});
}

final class CompleteExcerciseSuccessful extends RecomendationState {
  final String sucessMessage;

  const CompleteExcerciseSuccessful({required this.sucessMessage});
}

final class CompleteExcerciseLoading extends RecomendationState {}

final class GetRecomendationBySelectedEmotionLoading
    extends RecomendationState {}

final class GetRecomendationBySelectedEmotionFailed extends RecomendationState {
  final String errorMessage;

  const GetRecomendationBySelectedEmotionFailed({required this.errorMessage});
}

final class GetRecomendationBySelectedEmotionLoaded extends RecomendationState {
  final List<RecomendationByEmoitionsModel> emotionsRecomendations;

  const GetRecomendationBySelectedEmotionLoaded({
    required this.emotionsRecomendations,
  });
}
