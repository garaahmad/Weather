import 'package:globalweather/features/weather/data/repositories/settings_repository.dart';

class TemperatureConverter {
  static double convert(double celsius, TemperatureUnit unit) {
    if (unit == TemperatureUnit.fahrenheit) {
      return (celsius * 9 / 5) + 32;
    }
    return celsius;
  }

  static String format(double celsius, TemperatureUnit unit) {
    final value = convert(celsius, unit);
    final unitString = unit == TemperatureUnit.celsius ? '°C' : '°F';
    return '${value.round()}$unitString';
  }
}
