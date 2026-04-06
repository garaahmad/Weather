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
    final response = await client.get(
      Uri.parse('${ApiConstants.baseUrl}weather?q=$cityName&appid=${ApiConstants.apiKey}&units=metric'),
    );

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Future<WeatherModel> getWeatherDataByCoords(double lat, double lon) async {
    final response = await client.get(
      Uri.parse('${ApiConstants.baseUrl}weather?lat=$lat&lon=$lon&appid=${ApiConstants.apiKey}&units=metric'),
    );

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
