import 'dart:io';

import 'package:purchases_flutter/purchases_flutter.dart';

class RevenueCatService {
  // Get these from RevenueCat Dashboard → API Keys
  static const String apiKeyIOS = 'appl_tYYaiaZOqzDFjjVfvDxcetTTvHS';
  static const String apiKeyAndroid = 'goog_lUCieNVQuSnYCQXQMsvVWkMTRUc';

  // This is your entitlement ID (create in RevenueCat Dashboard)
  static const String entitlementID = 'pro membership';

  /// Initialize RevenueCat SDK
  Future<void> initialize() async {
    // Configure SDK based on platform
    PurchasesConfiguration configuration;
    if (Platform.isIOS) {
      configuration = PurchasesConfiguration(apiKeyIOS);
    } else if (Platform.isAndroid) {
      configuration = PurchasesConfiguration(apiKeyAndroid);
    } else {
      throw UnsupportedError('Platform not supported');
    }

    await Purchases.configure(configuration);

    print("✅ RevenueCat initialized successfully");
  }

  /// Get available subscription offerings
  Future<Offerings> getOfferings() async {
    final offerings = await Purchases.getOfferings();
    print("📦 Offerings fetched: ${offerings.all.length} offering(s)");
    return offerings;
  }

  /// Purchase a subscription package
  Future<CustomerInfo> purchasePackage(Package package) async {
    print("🛒 Purchasing package: ${package.identifier}");
    final purchaserInfo = await Purchases.purchasePackage(package);
    print("✅ Purchase completed!");
    return purchaserInfo.customerInfo;
  }

  /// Restore previous purchases
  Future<CustomerInfo> restorePurchases() async {
    final customerInfo = await Purchases.restorePurchases();
    return customerInfo;
  }

  /// Check if user has active premium subscription
  Future<bool> isPremium() async {
    final customerInfo = await Purchases.getCustomerInfo();
    final isPremium = customerInfo.entitlements.active.containsKey(
      entitlementID,
    );

    return isPremium;
  }

  /// Get customer info (includes all subscription details)
  Future<CustomerInfo> getCustomerInfo() async {
    return await Purchases.getCustomerInfo();
  }

  /// Get list of active subscription IDs
  Future<List<String>> getActiveSubscriptions() async {
    final customerInfo = await Purchases.getCustomerInfo();
    return customerInfo.activeSubscriptions.toList();
  }

  /// Set user ID (optional - for cross-device syncing)
  Future<CustomerInfo> setUserId(String userId) async {
    final result = await Purchases.logIn(userId);
    return result.customerInfo;
  }

  /// Logout user (clears user ID)
  Future<CustomerInfo> logout() async {
    final result = await Purchases.logOut();
    return result;
  }

  /// Get expiration date of active subscription
  Future<String?> getExpirationDate() async {
    final customerInfo = await Purchases.getCustomerInfo();
    final entitlement = customerInfo.entitlements.active[entitlementID];
    return entitlement?.expirationDate;
  }
}
