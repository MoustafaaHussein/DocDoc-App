import 'package:dartz/dartz.dart';
import 'package:docdoc_app/core/errors/in_app_purchase_error_handling.dart';
import 'package:docdoc_app/features/payment/data/remote_data_source/remote/payment_remote_data_source.dart';
import 'package:docdoc_app/features/payment/domain/repos/payment_repo.dart';
import 'package:in_app_purchase_platform_interface/src/types/product_details.dart';

class PaymentRepoImpl implements PaymentRepo {
  final PaymentRemoteDataSource payment;

  PaymentRepoImpl({required this.payment});

  @override
  Future<Either<Failure, List<ProductDetails>>> loadProducts() async {
    final response = await payment.loadProducts();
    if (response.error != null) {
      return left(InAppPurchaseFaliure(response.error!.message));
    }
    return right(response.productDetails);
  }

  @override
  Future<Either<Failure, void>> restorePurchase() async {
    await payment.restorePurchase();
    return right(null);
  }

  @override
  Future<Either<Failure, void>> subscribe(ProductDetails product) async {
    await payment.subscribe(product);
    return right(null);
  }

  @override
  Stream<bool> subscriptionStatus() {
    return payment.subscriptionStatus();
  }

  @override
  Future<Either<Failure, bool>> isUserSubscribed() async {
    final result = await payment.isUserSubscribed();
    return right(result);
  }
}
