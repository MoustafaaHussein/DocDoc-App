import 'package:equatable/equatable.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

abstract class SubscriptionState extends Equatable {
  const SubscriptionState();

  @override
  List<Object?> get props => [];
}

class SubscriptionInitial extends SubscriptionState {
  const SubscriptionInitial();
}

class SubscriptionLoading extends SubscriptionState {
  const SubscriptionLoading();
}

class OfferingsLoaded extends SubscriptionState {
  final Offerings offerings;

  const OfferingsLoaded(this.offerings);

  @override
  List<Object?> get props => [offerings];
}

class PremiumActive extends SubscriptionState {
  final CustomerInfo customerInfo;

  const PremiumActive(this.customerInfo);

  @override
  List<Object?> get props => [customerInfo];
}

class PremiumInactive extends SubscriptionState {
  const PremiumInactive();
}

class PurchaseSuccess extends SubscriptionState {
  final CustomerInfo customerInfo;

  const PurchaseSuccess(this.customerInfo);

  @override
  List<Object?> get props => [customerInfo];
}

class PurchaseCancelled extends SubscriptionState {
  const PurchaseCancelled();
}

class SubscriptionError extends SubscriptionState {
  final String message;

  const SubscriptionError(this.message);

  @override
  List<Object?> get props => [message];
}

class RestoreSuccess extends SubscriptionState {
  final CustomerInfo customerInfo;

  const RestoreSuccess(this.customerInfo);

  @override
  List<Object?> get props => [customerInfo];
}
