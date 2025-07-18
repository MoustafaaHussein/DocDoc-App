import 'package:dio/dio.dart';
import 'package:docdoc_app/core/helpers/api_service.dart';
import 'package:docdoc_app/features/payment/data/local_data_source/payment_local_data_source.dart';
import 'package:docdoc_app/features/payment/data/repos/payment_repositry_implementation.dart';
import 'package:docdoc_app/features/payment/domain/repos/payment_repositry.dart';
import 'package:docdoc_app/features/recomendation/data/data_source/remote_data_source/recomendation_remote_data_source.dart';
import 'package:docdoc_app/features/recomendation/data/repos/recomendation_repo_implementation.dart';
import 'package:docdoc_app/features/recomendation/domain/repos/recomendation_repo.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void serviceLocator() {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerSingleton<RecomendationRemoteDataSource>(
    RecomendationRemoteDataSourceImpl(getIt.get<ApiService>()),
  );
  getIt.registerSingleton<RecomendationRepo>(
    RecomendationRepoImplementation(
      recomendationRemoteDataSource: getIt.get<RecomendationRemoteDataSource>(),
    ),
  );
  getIt.registerSingleton<PaymentLocalDataSource>(
    PaymentLocalDataSourceImplementation(),
  );
  getIt.registerSingleton<PaymentRepositry>(
    PaymentRepositryImplementation(getIt.get<PaymentLocalDataSource>()),
  );
}
