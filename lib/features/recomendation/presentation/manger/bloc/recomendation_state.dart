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
