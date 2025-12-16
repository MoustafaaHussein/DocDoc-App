// data/models/subscription_product_model.dart
import 'package:docdoc_app/features/payment/domain/entites/subscription_product_entity/subscription_products.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class SubscriptionProductModel extends SubscriptionPlan {
  SubscriptionProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
  });

  factory SubscriptionProductModel.fromProductDetails(ProductDetails product) {
    return SubscriptionProductModel(
      id: product.id,
      title: product.title,
      description: product.description,
      price: product.price,
    );
  }
}
