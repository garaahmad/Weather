import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Centralized network connectivity checker.
/// Handles all scenarios:
/// 1. No connection at all (airplane mode, WiFi/data off)
/// 2. Connected to WiFi/data but no actual internet (captive portal, DNS failure)
/// 3. Intermittent connection (drops mid-request)
class NetworkInfo {
  static final Connectivity _connectivity = Connectivity();

  /// Check if the device has an active network interface (WiFi, mobile, etc.)
  static Future<bool> hasNetworkInterface() async {
    final result = await _connectivity.checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }

  /// Check if the device actually has working internet by pinging a reliable host.
  /// This catches "connected but no internet" scenarios.
  static Future<bool> hasInternetAccess() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 5));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    } on TimeoutException {
      return false;
    } catch (_) {
      return false;
    }
  }

  /// Full connectivity check: has network interface AND actual internet.
  static Future<bool> isConnected() async {
    final hasInterface = await hasNetworkInterface();
    if (!hasInterface) return false;
    return await hasInternetAccess();
  }

  /// Stream that fires whenever connectivity changes.
  static Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged;
}
