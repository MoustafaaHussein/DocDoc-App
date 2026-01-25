import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class SubscriptionFailure extends Failure {
  const SubscriptionFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class PurchaseCancelledFailure extends Failure {
  const PurchaseCancelledFailure(super.message);
}
