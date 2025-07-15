import 'dart:convert';

import 'package:docdoc_app/core/helpers/constants.dart';
import 'package:docdoc_app/core/helpers/secure_storage.dart';
import 'package:docdoc_app/features/payment/domain/entites/credit_card_entity.dart';

abstract class PaymentLocalDataSource {
  Future<void> addCreditCard(CreditCardEntity cardData);
  Future<List<CreditCardEntity>> deleteCreditCard(int cardId);
  Future<List<CreditCardEntity>> editCreditCard(int cardId);
  Future<List<CreditCardEntity>> getAllCards();
}

class PaymentLocalDataSourceImplementation extends PaymentLocalDataSource {
  @override
  Future<List<CreditCardEntity>> deleteCreditCard(int cardId) {
    // TODO: implement deleteCreditCard
    throw UnimplementedError();
  }

  @override
  Future<List<CreditCardEntity>> editCreditCard(int cardId) async {
    // TODO: implement deleteCreditCard
    throw UnimplementedError();
  }

  @override
  Future<void> addCreditCard(CreditCardEntity cardData) async {
    final existingJson = await SecureStorage.readValue(Constants.cardsKey);
    List<CreditCardEntity> existingCards = [];

    if (existingJson != null) {
      final List<dynamic> decoded = json.decode(existingJson);
      existingCards =
          decoded
              .map((e) => CreditCardEntity.fromJson(e as Map<String, dynamic>))
              .toList();
    }

    existingCards.add(cardData);
    final newJson = json.encode(existingCards.map((c) => c.toJson()).toList());

    await SecureStorage.writeValue(Constants.cardsKey, newJson);
  }

  @override
  Future<List<CreditCardEntity>> getAllCards() async {
    final jsonString = await SecureStorage.readValue(Constants.cardsKey);
    if (jsonString == null) return [];

    final List<dynamic> decoded = json.decode(jsonString);
    return decoded
        .map((e) => CreditCardEntity.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
