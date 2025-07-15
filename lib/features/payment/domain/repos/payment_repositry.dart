import 'package:docdoc_app/features/payment/domain/entites/credit_card_entity.dart';

abstract class PaymentRepositry {
  Future<List<CreditCardEntity>> getAllCards();
  Future<void> addNewCreditCard({required CreditCardEntity creditCard});
}
