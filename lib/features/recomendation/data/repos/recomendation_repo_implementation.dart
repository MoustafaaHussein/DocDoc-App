import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:docdoc_app/core/errors/failure.dart';
import 'package:docdoc_app/features/recomendation/data/data_source/remote_data_source/recomendation_remote_data_source.dart';
import 'package:docdoc_app/features/recomendation/data/models/personalize_recomendation_model/personalize_recomendation_model.dart';
import 'package:docdoc_app/features/recomendation/domain/repos/recomendation_repo.dart';

class RecomendationRepoImplementation implements RecomendationRepo {
  final RecomendationRemoteDataSource recomendationRemoteDataSource;

  RecomendationRepoImplementation({
    required this.recomendationRemoteDataSource,
  });
  @override
  Future<Either<RequestFailure, List<PersonalizeRecomendationModel>>>
  getPersonalizeRecomendation() async {
    try {
      var result =
          await recomendationRemoteDataSource.getPersonalizeRecomendation();
      return right(result);
    } catch (e) {
      if (e is DioException) {
        return Left(ServiceFailure.fromDioError(e));
      } else {
        return Left(ServiceFailure(errorMessage: e.toString()));
      }
    }
  }
}
