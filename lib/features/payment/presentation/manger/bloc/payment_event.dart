part of 'payment_bloc.dart';

@immutable
sealed class PaymentEvent {}

final class AddNewPaymentMethodEvent extends PaymentEvent {
  final CreditCardEntity creditCards;

  AddNewPaymentMethodEvent({required this.creditCards});
}

final class GetAllCreditCardsEvent extends PaymentEvent {}
