part of 'recomendation_bloc.dart';

sealed class RecomendationEvent extends Equatable {
  const RecomendationEvent();

  @override
  List<Object> get props => [];
}

class PersonalizeRecomendationEvent extends RecomendationEvent {}

class CategoryRecomendationEvent extends RecomendationEvent {
  final String subCategory;

  const CategoryRecomendationEvent({required this.subCategory});
}

class CompleteExcerciseEvent extends RecomendationEvent {
  final String feedBack;
  final int excersiceId;

  const CompleteExcerciseEvent(this.feedBack, this.excersiceId);
}
