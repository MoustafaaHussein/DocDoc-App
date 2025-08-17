part of 'subscription_cubit.dart';

sealed class SubscriptionState extends Equatable {
  const SubscriptionState();

  @override
  List<Object> get props => [];
}

final class SubscriptionInitial extends SubscriptionState {}

final class SubscriptionLoading extends SubscriptionState {}

final class SubscriptionLoaded extends SubscriptionState {
  final bool isPro;

  const SubscriptionLoaded(this.isPro);
}

final class SubscriptionError extends SubscriptionState {
  final String message;

  const SubscriptionError(this.message);
}
