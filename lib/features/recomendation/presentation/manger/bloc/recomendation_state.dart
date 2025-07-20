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
