import 'package:dailycanhan/constants/const.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final SecureStorage _singleton = SecureStorage._internal();
  var _storage;

  factory SecureStorage() {
    return _singleton;
  }

  SecureStorage._internal() {
    _storage = const FlutterSecureStorage();
  }

  Future<void> save(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String> get(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  Future<String> getAccessToken() async {
    return await get(CONST.ACCESS_TOKEN);
  }

  Future<void> saveAccessToken(String value) async {
    await save(CONST.ACCESS_TOKEN, value);
  }

  Future<void> removeAccessToken() async {
    await delete(CONST.ACCESS_TOKEN);
  }

  register(FlutterSecureStorage secureStorage) {
    _storage = secureStorage;
  }
}

final secureStorage = SecureStorage();
