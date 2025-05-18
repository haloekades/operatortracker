import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:operatortracker/features/login/domain/entities/login_entity.dart';

class StorageManager {
  static const _loginKey = 'login_entity_key';
  static const _tokenKey = 'token_key';

  final FlutterSecureStorage _storage;

  StorageManager({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  Future<void> saveLoginEntity(LoginEntity entity) async {
    final jsonString = jsonEncode(entity.toJson());
    await _storage.write(key: _loginKey, value: jsonString);
  }

  Future<LoginEntity?> loadLoginEntity() async {
    final jsonString = await _storage.read(key: _loginKey);
    if (jsonString == null) return null;
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return LoginEntity.fromJson(jsonMap);
  }

  Future<void> clearLoginEntity() async {
    await _storage.delete(key: _loginKey);
  }

  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<String?> loadToken() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<void> clearToken() async {
    await _storage.delete(key: _tokenKey);
  }

  Future<void> clearAllData() async {
    await _storage.deleteAll();
  }
}
