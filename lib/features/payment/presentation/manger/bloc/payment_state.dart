part of 'payment_bloc.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class AddPaymentMethodSuccess extends PaymentState {}

final class AddPaymentMethodLoading extends PaymentState {}

final class GetAllPaymentMethodsSuccess extends PaymentState {
  final List<CreditCardEntity> creditCards;

  GetAllPaymentMethodsSuccess(this.creditCards);
}

final class GetAllPaymentMethodLoading extends PaymentState {}

final class DeleteCreditCardSuccess extends PaymentState {}
