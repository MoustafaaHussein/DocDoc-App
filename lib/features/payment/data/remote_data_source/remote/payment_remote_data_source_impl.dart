import 'dart:async';

import 'package:docdoc_app/core/services/in_app_purches_service.dart';
import 'package:docdoc_app/features/payment/data/local_data_source/payment_local_data_source.dart';
import 'package:docdoc_app/features/payment/data/remote_data_source/remote/payment_remote_data_source.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final InAppPurchaseService inAppPurchaseService;
  // ALL your subscription product IDs
  static const String monthlySubId = 'mymood_2_99_1m';
  static const String yearlySubId = 'mymood_32_99_1y';
  static const String sixMonthlySubId = 'mymood_15_99_6m';
  static const String groupSubId = 'pro_plans';

  static const Set<String> _allSubscriptionIds = {
    monthlySubId,
    yearlySubId,
    sixMonthlySubId,
    groupSubId,
  };

  PaymentRemoteDataSourceImpl({required this.inAppPurchaseService});

  @override
  Future<ProductDetailsResponse> loadProducts() async {
    return await inAppPurchaseService.getProducts(_allSubscriptionIds);
  }

  @override
  Future<void> restorePurchase() async {
    await inAppPurchaseService.restorePurchases();
  }

  @override
  Stream<bool> subscriptionStatus() {
    return inAppPurchaseService.purchaseStream.map((purchase) {
      return _allSubscriptionIds.contains(purchase.productID) &&
          (purchase.status == PurchaseStatus.purchased ||
              purchase.status == PurchaseStatus.restored);
    });
  }

  @override
  Future<bool> isUserSubscribed() async {
    // Step 1: Check local storage (fast)

    await SecureSubscriptionStorage().isSubscribed();

    // Step 2: If not found locally, verify with store

    final completer = Completer<bool>();
    late final StreamSubscription<PurchaseDetails> sub;

    sub = inAppPurchaseService.purchaseStream.listen((purchase) async {
      if (_allSubscriptionIds.contains(purchase.productID) &&
          (purchase.status == PurchaseStatus.purchased ||
              purchase.status == PurchaseStatus.restored)) {
        // Restore to local storage
        await SecureSubscriptionStorage().saveSubscription(purchase.productID);

        if (!completer.isCompleted) {
          sub.cancel();
          completer.complete(true);
        }
      }
    });

    // Trigger restore from store
    await inAppPurchaseService.restorePurchases();

    // Timeout after 5 seconds
    Timer(const Duration(seconds: 5), () {
      if (!completer.isCompleted) {
        sub.cancel();
        completer.complete(false);
      }
    });

    return completer.future;
  }

  @override
  Future<void> subscribe(ProductDetails product) async {
    await inAppPurchaseService.buySubscribe(product);
  }
}
