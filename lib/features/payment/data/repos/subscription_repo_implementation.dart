import 'package:dartz/dartz.dart';
import 'package:docdoc_app/core/errors/revenucat_failure.dart';
import 'package:docdoc_app/features/payment/data/remote_data_source/remote/subscription_data_source.dart';
import 'package:docdoc_app/features/payment/domain/repos/subscription_repo.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final SubscriptionRemoteDataSource _dataSource;

  SubscriptionRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, Offerings>> getOfferings() async {
    try {
      final offerings = await _dataSource.getOfferings();
      return Right(offerings);
    } on PlatformException catch (e) {
      return Left(SubscriptionFailure(e.message ?? 'Failed to get offerings'));
    } catch (e) {
      return Left(SubscriptionFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CustomerInfo>> purchasePackage(Package package) async {
    try {
      final customerInfo = await _dataSource.purchasePackage(package);
      return Right(customerInfo);
    } on PlatformException catch (e) {
      final errorCode = PurchasesErrorHelper.getErrorCode(e);

      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        return const Left(PurchaseCancelledFailure('Purchase was cancelled'));
      } else if (errorCode == PurchasesErrorCode.networkError) {
        return const Left(NetworkFailure('Network error occurred'));
      } else {
        return Left(SubscriptionFailure(e.message ?? 'Purchase failed'));
      }
    } catch (e) {
      return Left(SubscriptionFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CustomerInfo>> restorePurchases() async {
    try {
      final customerInfo = await _dataSource.restorePurchases();
      return Right(customerInfo);
    } on PlatformException catch (e) {
      return Left(
        SubscriptionFailure(e.message ?? 'Failed to restore purchases'),
      );
    } catch (e) {
      return Left(SubscriptionFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isPremium() async {
    try {
      final isPremium = await _dataSource.isPremium();
      return Right(isPremium);
    } catch (e) {
      return Left(SubscriptionFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CustomerInfo>> getCustomerInfo() async {
    try {
      final customerInfo = await _dataSource.getCustomerInfo();
      return Right(customerInfo);
    } catch (e) {
      return Left(SubscriptionFailure(e.toString()));
    }
  }
}
