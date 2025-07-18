import 'package:dartz/dartz.dart';
import 'package:docdoc_app/core/errors/failure.dart';
import 'package:docdoc_app/features/recomendation/data/models/personalize_recomendation_model/personalize_recomendation_model.dart';

abstract class RecomendationRepo {
  Future<Either<RequestFailure, List<PersonalizeRecomendationModel>>>
  getPersonalizeRecomendation();
}
