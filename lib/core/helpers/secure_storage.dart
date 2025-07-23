import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  // ✅ Key names for secure storage
  static const String _tapLiveKeyName = 'tap_live_key';
  static const String _tapTestKeyName = 'tap_test_key';
  static const String _tapEnvKeyName = 'tap_env'; // 'live' or 'test'

  static late FlutterSecureStorage storage;

  static Future<void> init() async {
    storage = const FlutterSecureStorage();
  }

  // ✅ Generic helpers
  static Future<String?> readValue(String key) async {
    return await storage.read(key: key);
  }

  static Future<void> writeValue(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  static Future<void> deleteValue(String key) async {
    await storage.delete(key: key);
  }

  static Future<Map<String, String>> readAllValues() async {
    return await storage.readAll();
  }

  static Future<void> deleteAllValues() async {
    await storage.deleteAll();
  }

  // ✅ Tap-specific helpers
  static Future<void> setTapLiveKey(String value) async {
    await writeValue(_tapLiveKeyName, value);
  }

  static Future<void> setTapTestKey(String value) async {
    await writeValue(_tapTestKeyName, value);
  }

  static Future<void> setTapEnv(String env) async {
    // env = 'live' or 'test'
    await writeValue(_tapEnvKeyName, env);
  }

  static Future<String?> getTapKey() async {
    final env = await readValue(_tapEnvKeyName);
    if (env == 'live') {
      return await readValue(_tapLiveKeyName);
    } else {
      return await readValue(_tapTestKeyName);
    }
  }
}
