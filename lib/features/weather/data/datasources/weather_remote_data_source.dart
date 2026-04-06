import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:globalweather/core/network/api_constants.dart';
import 'package:globalweather/features/weather/data/models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getWeatherData(String cityName);
  Future<WeatherModel> getWeatherDataByCoords(double lat, double lon);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getWeatherData(String cityName) async {
    final weatherResponse = await client.get(
      Uri.parse('${ApiConstants.baseUrl}weather?q=$cityName&appid=${ApiConstants.apiKey}&units=metric'),
    );
    final forecastResponse = await client.get(
      Uri.parse('${ApiConstants.baseUrl}forecast?q=$cityName&appid=${ApiConstants.apiKey}&units=metric'),
    );

    if (weatherResponse.statusCode == 200 && forecastResponse.statusCode == 200) {
      return WeatherModel.fromCombinedJson(
        json.decode(weatherResponse.body),
        json.decode(forecastResponse.body),
      );
    } else {
      throw Exception('Failed to load weather/forecast data');
    }
  }

  @override
  Future<WeatherModel> getWeatherDataByCoords(double lat, double lon) async {
    final weatherResponse = await client.get(
      Uri.parse('${ApiConstants.baseUrl}weather?lat=$lat&lon=$lon&appid=${ApiConstants.apiKey}&units=metric'),
    );
    final forecastResponse = await client.get(
      Uri.parse('${ApiConstants.baseUrl}forecast?lat=$lat&lon=$lon&appid=${ApiConstants.apiKey}&units=metric'),
    );

    if (weatherResponse.statusCode == 200 && forecastResponse.statusCode == 200) {
      return WeatherModel.fromCombinedJson(
        json.decode(weatherResponse.body),
        json.decode(forecastResponse.body),
      );
    } else {
      throw Exception('Failed to load weather/forecast data');
    }
  }
}
