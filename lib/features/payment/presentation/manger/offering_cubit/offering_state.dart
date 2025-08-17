part of 'offering_cubit.dart';

sealed class OfferingState extends Equatable {
  const OfferingState();

  @override
  List<Object> get props => [];
}

final class OfferingInitial extends OfferingState {}

final class OfferingLoading extends OfferingState {}

final class OfferingLoaded extends OfferingState {
  final List<Package> package;

  const OfferingLoaded(this.package);
}

final class OfferingError extends OfferingState {
  final String message;

  const OfferingError(this.message);
}
