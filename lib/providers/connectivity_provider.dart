import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityProvider extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  bool _isOnline = true;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  bool get isOnline => _isOnline;

  ConnectivityProvider() {
    _initConnectivity();
    _subscription = _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      _updateStatus(results);
    });
  }

  Future<void> _initConnectivity() async {
    try {
      final List<ConnectivityResult> results = await _connectivity.checkConnectivity();
      _updateStatus(results);
    } catch (_) {
      _isOnline = false;
      notifyListeners();
    }
  }

  void _updateStatus(List<ConnectivityResult> results) {
    // If any connection result is not 'none', we are online.
    final bool online = results.isNotEmpty && results.first != ConnectivityResult.none;
    if (_isOnline != online) {
      _isOnline = online;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
