import 'package:purchases_flutter/purchases_flutter.dart';

abstract class SubscriptionRemoteDataSource {
  Future<Offerings> getOfferings();
  Future<CustomerInfo> purchasePackage(Package package);
  Future<CustomerInfo> restorePurchases();
  Future<bool> isPremium();
  Future<CustomerInfo> getCustomerInfo();
}
