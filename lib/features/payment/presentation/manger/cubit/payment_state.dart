import 'package:docdoc_app/features/payment/domain/entites/subscription_product_entity/subscription_products.dart';

abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentLoaded extends PaymentState {
  final List<SubscriptionPlan> plans; // Domain model for your UI
  PaymentLoaded(this.plans);
}

class PaymentPurchasing extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final SubscriptionPlan? purchasedPlan;
  PaymentSuccess({this.purchasedPlan});
}

class PaymentError extends PaymentState {
  final String message;
  PaymentError(this.message);
}
