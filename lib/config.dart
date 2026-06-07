import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {
  static String _ipAddress = '192.168.1.88'; // Default fallback IP

  static String get ipAddress => _ipAddress;

  static String get baseUrl => 'http://$_ipAddress:8000/api';

  /// Load IP from SharedPreferences
  static Future<void> loadIp() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _ipAddress = prefs.getString('api_ip_address') ?? '192.168.1.88';
    } catch (_) {
      // Fallback to default if SharedPreferences fails (e.g. initial start)
      _ipAddress = '192.168.1.88';
    }
  }

  /// Save IP to SharedPreferences and update memory cache
  static Future<void> saveIp(String ip) async {
    _ipAddress = ip.trim();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('api_ip_address', _ipAddress);
    } catch (_) {}
  }
}
