import 'dart:async';

import 'package:docdoc_app/features/payment/data/local_data_source/payment_local_data_source.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class InAppPurchaseService {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late final StreamSubscription<List<PurchaseDetails>> _streamSubscription;
  final StreamController<PurchaseDetails> _purchaseController =
      StreamController.broadcast();

  Stream<PurchaseDetails> get purchaseStream => _purchaseController.stream;

  Future<void> initialize() async {
    final isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) throw Exception('In-app purchases not available');

    _streamSubscription = _inAppPurchase.purchaseStream.listen(
      _onPurchaseUpdate,
      onError: (error) => throw Exception('Purchase stream error: $error'),
      onDone: () => _streamSubscription.cancel(),
    );
  }

  Future<void> completePurchase(PurchaseDetails purchase) async {
    if (purchase.pendingCompletePurchase) {
      await _inAppPurchase.completePurchase(purchase);
    }
  }

  Future<bool> isAvailable() async {
    return await _inAppPurchase.isAvailable();
  }

  Future<ProductDetailsResponse> getProducts(Set<String> identifiers) async {
    return await _inAppPurchase.queryProductDetails(identifiers);
  }

  Future<void> buySubscribe(ProductDetails productDetails) async {
    final purchaseParam = PurchaseParam(productDetails: productDetails);
    await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  Future<void> restorePurchases() async {
    await _inAppPurchase.restorePurchases();
  }

  void _onPurchaseUpdate(List<PurchaseDetails> purchases) async {
    for (var purchase in purchases) {
      print(
        "🔔 Purchase update: ${purchase.productID}, Status: ${purchase.status}",
      );

      _purchaseController.add(purchase);

      if (purchase.status == PurchaseStatus.purchased ||
          purchase.status == PurchaseStatus.restored) {
        await SecureSubscriptionStorage().saveSubscription(purchase.productID);
        print("💾 Subscription synced to local storage!");
      }

      // Complete new purchases only
      if (purchase.status == PurchaseStatus.purchased) {
        completePurchase(purchase);
      }
    }
  }

  Future<List<PurchaseDetails>> getPastPurchases() async {
    await _inAppPurchase.restorePurchases();

    final completer = Completer<List<PurchaseDetails>>();
    final List<PurchaseDetails> collectedPurchases = [];

    late StreamSubscription<List<PurchaseDetails>> sub;

    sub = _inAppPurchase.purchaseStream.listen((purchases) {
      collectedPurchases.addAll(purchases);
    });

    await Future.delayed(const Duration(seconds: 3));
    await sub.cancel();

    completer.complete(collectedPurchases);
    return collectedPurchases;
  }

  void dispose() {
    _streamSubscription.cancel();
    _purchaseController.close();
  }
}
