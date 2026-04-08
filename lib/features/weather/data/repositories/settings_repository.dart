import 'package:shared_preferences/shared_preferences.dart';

enum TemperatureUnit { celsius, fahrenheit }

class SettingsRepository {
  static const String _unitKey = 'temp_unit';

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
}
