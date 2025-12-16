import 'package:docdoc_app/features/payment/domain/entites/subscription_product_entity/subscription_products.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

abstract class PaymentRepositry {
  Future<List<SubscriptionPlan>> getPlans();
  Future<void> buyPlan(String productId);
  Stream<PurchaseDetails> get purchaseUpdates;
}
