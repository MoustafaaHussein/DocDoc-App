import 'package:dartz/dartz.dart';
import 'package:docdoc_app/core/errors/revenucat_failure.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

abstract class SubscriptionRepository {
  Future<Either<Failure, Offerings>> getOfferings();
  Future<Either<Failure, CustomerInfo>> purchasePackage(Package package);
  Future<Either<Failure, CustomerInfo>> restorePurchases();
  Future<Either<Failure, bool>> isPremium();
  Future<Either<Failure, CustomerInfo>> getCustomerInfo();
}
