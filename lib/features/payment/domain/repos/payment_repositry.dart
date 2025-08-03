import 'package:dartz/dartz.dart';
import 'package:docdoc_app/core/errors/failure.dart';
import 'package:docdoc_app/features/payment/data/models/get_pro_plans/datum.dart';
import 'package:docdoc_app/features/payment/domain/entites/credit_card_entity.dart';

abstract class PaymentRepositry {
  Future<List<CreditCardEntity>> getAllCards();
  Future<void> addNewCreditCard({required CreditCardEntity creditCard});
  Future<void> deleteCreditCard({required String cardId});
  Future<Either<RequestFailure, List<ProPlans>>> getProPlans();
}
