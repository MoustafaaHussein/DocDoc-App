import 'package:in_app_purchase/in_app_purchase.dart';

abstract class SubscriptionState {}

class SubscriptionInitial extends SubscriptionState {}

class SubscriptionLoading extends SubscriptionState {}

class SubscriptionActive extends SubscriptionState {}

class SubscriptionInactive extends SubscriptionState {}

class SubscriptionError extends SubscriptionState {
  final String message;
  SubscriptionError(this.message);
}

class ProductsLoaded extends SubscriptionState {
  final List<ProductDetails> products;
  ProductsLoaded(this.products);
}

class SubscriptionSuccess extends SubscriptionState {
  final String message;
  SubscriptionSuccess([this.message = 'Subscription Successful! 🎉']);
}

class SubscriptionPremiumAccessGranted extends SubscriptionState {}

class SubscriptionPremiumAccessDenied extends SubscriptionState {}
