import 'package:shared_preferences/shared_preferences.dart';

enum TemperatureUnit { celsius, fahrenheit }

class SettingsRepository {
  static const String _unitKey = 'temp_unit';
  static const String _notificationsKey = 'notifications_enabled';

  Future<void> saveTemperatureUnit(TemperatureUnit unit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_unitKey, unit.toString());
  }

  Future<TemperatureUnit> getTemperatureUnit() async {
    final prefs = await SharedPreferences.getInstance();
    final unitString = prefs.getString(_unitKey);
    if (unitString == TemperatureUnit.fahrenheit.toString()) {
      return TemperatureUnit.fahrenheit;
    }
    return TemperatureUnit.celsius;
  }

  Future<void> saveNotificationsEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationsKey, enabled);
  }

  Future<bool> getNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_notificationsKey) ?? false;
  }
}
