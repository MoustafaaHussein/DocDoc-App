import 'package:dio/dio.dart';
import 'package:docdoc_app/core/services/api_service.dart';
import 'package:docdoc_app/core/services/in_app_purches_service.dart';
import 'package:docdoc_app/core/services/revenucat_payment_service.dart';
import 'package:docdoc_app/features/payment/data/remote_data_source/remote/payment_remote_data_source.dart';
import 'package:docdoc_app/features/payment/data/remote_data_source/remote/payment_remote_data_source_impl.dart';
import 'package:docdoc_app/features/payment/data/remote_data_source/remote/subscription_data_source.dart';
import 'package:docdoc_app/features/payment/data/remote_data_source/remote/subscription_data_source_implementation.dart';
import 'package:docdoc_app/features/payment/data/repos/payment_repo_impl.dart';
import 'package:docdoc_app/features/payment/data/repos/subscription_repo_implementation.dart';
import 'package:docdoc_app/features/payment/domain/repos/payment_repo.dart';
import 'package:docdoc_app/features/payment/domain/repos/subscription_repo.dart';
import 'package:docdoc_app/features/recomendation/data/data_source/remote_data_source/recomendation_remote_data_source.dart';
import 'package:docdoc_app/features/recomendation/data/repos/recomendation_repo_implementation.dart';
import 'package:docdoc_app/features/recomendation/domain/repos/recomendation_repo.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
Future<void> serviceLocator() async {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));

  getIt.registerSingleton<RecomendationRemoteDataSource>(
    RecomendationRemoteDataSourceImpl(getIt.get<ApiService>()),
  );
  getIt.registerSingleton<RecomendationRepo>(
    RecomendationRepoImplementation(
      recomendationRemoteDataSource: getIt.get<RecomendationRemoteDataSource>(),
    ),
  );
  getIt.registerSingleton<InAppPurchaseService>(InAppPurchaseService());
  getIt.registerSingleton<PaymentRemoteDataSource>(
    PaymentRemoteDataSourceImpl(
      inAppPurchaseService: getIt.get<InAppPurchaseService>(),
    ),
  );
  getIt.registerSingleton<PaymentRepo>(
    PaymentRepoImpl(payment: getIt.get<PaymentRemoteDataSource>()),
  );
  final revenueCatService = RevenueCatService();
  await revenueCatService.initialize();
  getIt.registerSingleton<RevenueCatService>(revenueCatService);

  // 2. Register Data Source
  getIt.registerLazySingleton<SubscriptionRemoteDataSource>(
    () => SubscriptionRemoteDataSourceImpl(getIt<RevenueCatService>()),
  );

  // 3. Register Repository
  getIt.registerLazySingleton<SubscriptionRepository>(
    () => SubscriptionRepositoryImpl(getIt<SubscriptionRemoteDataSource>()),
  );
}
