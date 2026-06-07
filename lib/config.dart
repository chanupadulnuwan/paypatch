import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {
  static String _baseUrl = 'http://192.168.1.88/CB016173/paypatch-laravel/public/api'; // Default fallback for XAMPP

  static String get baseUrl => _baseUrl;

  /// Load Base URL from SharedPreferences
  static Future<void> loadIp() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _baseUrl = prefs.getString('api_base_url') ?? 'http://192.168.1.88/CB016173/paypatch-laravel/public/api';
    } catch (_) {
      _baseUrl = 'http://192.168.1.88/CB016173/paypatch-laravel/public/api';
    }
  }

  /// Save Base URL to SharedPreferences and update memory cache
  static Future<void> saveIp(String url) async {
    String formattedUrl = url.trim();
    if (formattedUrl.endsWith('/')) {
      formattedUrl = formattedUrl.substring(0, formattedUrl.length - 1);
    }
    _baseUrl = formattedUrl;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('api_base_url', _baseUrl);
    } catch (_) {}
  }
}
