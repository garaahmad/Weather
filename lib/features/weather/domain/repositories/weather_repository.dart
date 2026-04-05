import 'package:globalweather/features/weather/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<WeatherEntity> getWeather(String cityName);
}
