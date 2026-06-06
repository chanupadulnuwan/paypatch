import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class AnnouncementsProvider extends ChangeNotifier {
  List<dynamic> _announcements = [];
  bool _isLoading = false;
  bool _isLoadedFromExternal = false;

  List<dynamic> get announcements => _announcements;
  bool get isLoading => _isLoading;
  bool get isLoadedFromExternal => _isLoadedFromExternal;

  Future<void> fetchAnnouncements({bool isOnline = true}) async {
    _isLoading = true;
    notifyListeners();

    if (!isOnline) {
      await _loadFromLocalAsset();
      _isLoading = false;
      notifyListeners();
      return;
    }

    try {
      // Fetching from a public JSON hosting site (npoint.io)
      final response = await http.get(
        Uri.parse('https://api.npoint.io/b3ba6c728e2ad3b817df'),
      ).timeout(const Duration(seconds: 4));

      if (response.statusCode == 200) {
        _announcements = json.decode(response.body);
        _isLoadedFromExternal = true;
      } else {
        await _loadFromLocalAsset();
      }
    } catch (_) {
      await _loadFromLocalAsset();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadFromLocalAsset() async {
    try {
      final String response = await rootBundle.loadString('assets/local_announcements.json');
      _announcements = json.decode(response);
      _isLoadedFromExternal = false;
    } catch (_) {
      _announcements = [];
    }
  }
}
