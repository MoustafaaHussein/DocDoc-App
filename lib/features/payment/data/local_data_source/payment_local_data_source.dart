import 'dart:convert';

import 'package:docdoc_app/core/helpers/constants.dart';
import 'package:docdoc_app/core/helpers/secure_storage.dart';
import 'package:docdoc_app/features/payment/domain/entites/credit_card_entity.dart';

abstract class PaymentLocalDataSource {
  Future<void> addCreditCard(CreditCardEntity cardData);
  Future<void> deleteCreditCard(String cardId);
  Future<List<CreditCardEntity>> editCreditCard(String cardId);
  Future<List<CreditCardEntity>> getAllCards();
}

class PaymentLocalDataSourceImplementation extends PaymentLocalDataSource {
  @override
  Future<void> deleteCreditCard(String cardIdToDelete) async {
    // Changed return type to Future<void>
    final creditCardsJson = await SecureStorage.readValue(Constants.cardsKey);
    List<CreditCardEntity> creditCards = [];

    if (creditCardsJson == null || creditCardsJson.isEmpty) {
      // No cards stored, or corrupted data. Nothing to delete.
      return; // Return void
    }
    final List<dynamic> decode = json.decode(creditCardsJson);
    creditCards =
        decode
            .map((e) => CreditCardEntity.fromJson(e as Map<String, dynamic>))
            .toList();
    // Create a new list with the item filtered out
    final List<CreditCardEntity> updatedCreditCards =
        creditCards.where((element) => element.id != cardIdToDelete).toList();
    // Reserialize the modified list
    final List<Map<String, dynamic>> jsonList =
        updatedCreditCards.map((card) => card.toJson()).toList();
    final String encodedJson = json.encode(jsonList);
    // Save the modified list back to Secure Storage
    await SecureStorage.writeValue(Constants.cardsKey, encodedJson);

    // No explicit return statement needed for Future<void>
  }

  @override
  Future<List<CreditCardEntity>> editCreditCard(String cardId) async {
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
