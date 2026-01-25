import 'package:docdoc_app/core/services/revenucat_payment_service.dart';
import 'package:docdoc_app/features/payment/data/remote_data_source/remote/subscription_data_source.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionRemoteDataSourceImpl implements SubscriptionRemoteDataSource {
  final RevenueCatService _revenueCatService;

  SubscriptionRemoteDataSourceImpl(this._revenueCatService);

  @override
  Future<Offerings> getOfferings() async {
    return await _revenueCatService.getOfferings();
  }

  @override
  Future<CustomerInfo> purchasePackage(Package package) async {
    return await _revenueCatService.purchasePackage(package);
  }

  @override
  Future<CustomerInfo> restorePurchases() async {
    return await _revenueCatService.restorePurchases();
  }

  @override
  Future<bool> isPremium() async {
    return await _revenueCatService.isPremium();
  }

  @override
  Future<CustomerInfo> getCustomerInfo() async {
    return await _revenueCatService.getCustomerInfo();
  }
}
