import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'jwt_token';

  static Future<void> saveToken(String? token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  static Future<void> logout() async {
    await _storage.delete(key: 'jwt_token');
  }

  // Save object
  static Future<void> saveObject(String key, Map<String, dynamic> value) async {
    final jsonString = jsonEncode(value); // Serialize the object
    await _storage.write(key: key, value: jsonString);
  }

  // Retrieve object
  static Future<Map<String, dynamic>?> getObject(String key) async {
    final jsonString = await _storage.read(key: key);
    if (jsonString != null) {
      return jsonDecode(jsonString); // Deserialize the object
    }
    return null;
  }

  // Delete object
  static Future<void> deleteObject(String key) async {
    await _storage.delete(key: key);
  }
}
