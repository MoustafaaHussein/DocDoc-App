import 'package:docdoc_app/features/payment/data/local_data_source/payment_local_data_source.dart';
import 'package:docdoc_app/features/payment/data/repos/payment_repositry_implementation.dart';
import 'package:docdoc_app/features/payment/domain/repos/payment_repositry.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void serviceLocator() {
  getIt.registerSingleton<PaymentLocalDataSource>(
    PaymentLocalDataSourceImplementation(),
  );
  getIt.registerSingleton<PaymentRepositry>(
    PaymentRepositryImplementation(getIt.get<PaymentLocalDataSource>()),
  );
}
