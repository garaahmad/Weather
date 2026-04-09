import 'package:firebase_messaging/firebase_messaging.dart';

/// Service responsible for subscribing/unsubscribing to Firebase FCM topics
/// based on the user's current city/location.
class FcmTopicService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  static String _sanitizeCityName(String cityName) {
    // FCM topic names must match: [a-zA-Z0-9-_.~%]
    return cityName
        .toLowerCase()
        .replaceAll(' ', '_')
        .replaceAll(RegExp(r'[^a-z0-9_]'), '');
  }

  /// Subscribe to a weather topic for a city.
  Future<void> subscribeToCity(String cityName) async {
    final topic = 'weather_${_sanitizeCityName(cityName)}';
    await _fcm.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromCity(String cityName) async {
    final topic = 'weather_${_sanitizeCityName(cityName)}';
    await _fcm.unsubscribeFromTopic(topic);
  }

  Future<void> updateSubscription({
    required String? oldCityName,
    required String newCityName,
  }) async {
    if (oldCityName != null && oldCityName != newCityName) {
      await unsubscribeFromCity(oldCityName);
    }
    await subscribeToCity(newCityName);
  }

  Future<bool> requestNotificationPermission() async {
    final settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    return settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
  }

  Future<String?> getToken() => _fcm.getToken();
}
