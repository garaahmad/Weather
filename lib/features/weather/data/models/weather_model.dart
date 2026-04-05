import 'package:globalweather/features/weather/domain/entities/weather.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.cityName,
    required super.temperature,
    required super.condition,
    required super.humidity,
    required super.windSpeed,
    required super.uvIndex,
    required super.pressure,
    required super.sunrise,
    required super.sunset,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      condition: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      uvIndex: 0, // Placeholder
      pressure: json['main']['pressure'],
      sunrise: "6:15 AM", // Placeholder
      sunset: "8:30 PM", // Placeholder
    );
  }
}
