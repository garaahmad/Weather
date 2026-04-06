import 'package:globalweather/features/weather/domain/entities/weather.dart';
import 'package:globalweather/features/weather/domain/repositories/weather_repository.dart';
import 'package:globalweather/features/weather/data/datasources/weather_remote_data_source.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl({required this.remoteDataSource});

  @override
  Future<WeatherEntity> getWeather(String cityName) async {
    return await remoteDataSource.getWeatherData(cityName);
  }

  @override
  Future<WeatherEntity> getWeatherByCoords(double lat, double lon) async {
    return await remoteDataSource.getWeatherDataByCoords(lat, lon);
  }
}
