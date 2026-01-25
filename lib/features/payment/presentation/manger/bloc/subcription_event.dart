import 'package:equatable/equatable.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

abstract class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();

  @override
  List<Object?> get props => [];
}

class InitializeSubscription extends SubscriptionEvent {
  const InitializeSubscription();
}

class LoadOfferings extends SubscriptionEvent {
  const LoadOfferings();
}

class PurchasePackageEvent extends SubscriptionEvent {
  final Package package;

  const PurchasePackageEvent(this.package);

  @override
  List<Object?> get props => [package];
}

class RestorePurchasesEvent extends SubscriptionEvent {
  const RestorePurchasesEvent();
}

class CheckPremiumStatus extends SubscriptionEvent {
  const CheckPremiumStatus();
}
