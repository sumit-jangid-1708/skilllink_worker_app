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

  // Get Tokens
  static String? getToken() => _storage.read(_tokenKey);
  static String? getRefreshToken() => _storage.read(_refreshKey);

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
