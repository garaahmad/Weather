import 'package:globalweather/features/weather/domain/entities/weather.dart';
import 'package:globalweather/features/weather/domain/repositories/weather_repository.dart';

class GetWeatherUseCase {
  final WeatherRepository repository;

  GetWeatherUseCase(this.repository);

  Future<WeatherEntity> execute(String cityName) {
    return repository.getWeather(cityName);
  }
}
