import 'package:dartz/dartz.dart';
import 'package:docdoc_app/core/errors/in_app_purchase_error_handling.dart';
import 'package:in_app_purchase/in_app_purchase.dart';


abstract class PaymentRepo {
  Future<Either<Failure, List<ProductDetails>>> loadProducts();
  Future<Either<Failure, void>> restorePurchase();
  Future<Either<Failure, void>> subscribe(ProductDetails product);
  Future<Either<Failure, bool>> isUserSubscribed();
  Stream<bool> subscriptionStatus();
}