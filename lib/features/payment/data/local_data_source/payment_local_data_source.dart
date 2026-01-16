import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureSubscriptionStorage {
  static const String _keyIsSubscribed = 'is_subscribed';
  static const String _keyProductId = 'subscription_product_id';
  static const String _keyPurchaseDate = 'subscription_purchase_date';

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> saveSubscription(String productId) async {
    await _storage.write(key: _keyIsSubscribed, value: 'true');
    await _storage.write(key: _keyProductId, value: productId);
    await _storage.write(
      key: _keyPurchaseDate,
      value: DateTime.now().toIso8601String(),
    );
  }

  Future<bool> isSubscribed() async {
    final value = await _storage.read(key: _keyIsSubscribed);
    return value == 'true';
  }

  Future<String?> getProductId() async {
    return await _storage.read(key: _keyProductId);
  }

  Future<DateTime?> getPurchaseDate() async {
    final value = await _storage.read(key: _keyPurchaseDate);
    if (value == null) return null;
    return DateTime.tryParse(value);
  }

  Future<void> clearSubscription() async {
    await _storage.delete(key: _keyIsSubscribed);
    await _storage.delete(key: _keyProductId);
    await _storage.delete(key: _keyPurchaseDate);
  }
}
