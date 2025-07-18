part of 'recomendation_bloc.dart';

sealed class RecomendationEvent extends Equatable {
  const RecomendationEvent();

  @override
  List<Object> get props => [];
}

class PersonalizeRecomendationEvent extends RecomendationEvent {}
