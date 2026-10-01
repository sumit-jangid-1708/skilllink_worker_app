import 'package:get_storage/get_storage.dart';

class AppStorage {
  static final _storage = GetStorage();
  static const String _tokenKey = 'token';
  static const String _refreshKey = 'refresh_token';

  // Save Tokens
  static Future<void> saveToken(String token, {String? refresh}) async {
    await _storage.write(_tokenKey, token);
    if (refresh != null) {
      await _storage.write(_refreshKey, refresh);
    }
  }

  // Get Tokens (Added type safety)
  static String? getToken() {
    final data = _storage.read(_tokenKey);
    return data is String ? data : null;
  }

  static String? getRefreshToken() {
    final data = _storage.read(_refreshKey);
    return data is String ? data : null;
  }

  // Check if token exists
  static bool hasToken() {
    final token = getToken();
    return token != null && token.isNotEmpty;
  }

  // Remove Tokens (Logout)
  static Future<void> removeToken() async {
    await _storage.remove(_tokenKey);
    await _storage.remove(_refreshKey);
  }

  // Clear all storage
  static Future<void> clearAll() async {
    await _storage.erase();
  }
}
