import 'package:in_app_purchase/in_app_purchase.dart';

abstract class PaymentRemoteDataSource {
  Future<ProductDetailsResponse> loadProducts();
  Future<void> restorePurchase();
  Future<void> subscribe(ProductDetails product);
  Future<bool> isUserSubscribed();
  Stream<bool> subscriptionStatus();
}
