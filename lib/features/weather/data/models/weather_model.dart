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
    required super.forecastList,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    final main = json['main'];
    final wind = json['wind'];
    final sys = json['sys'];

    // Mock forecast data since the current API call only returns current weather
    final mockForecast = List.generate(7, (index) {
      final date = DateTime.now().add(Duration(days: index));
      return ForecastEntity(
        date: date,
        low: (main['temp_min'] as num).toDouble() - index,
        high: (main['temp_max'] as num).toDouble() + index,
        condition: index % 2 == 0 ? "Clear" : "Clouds",
      );
    });

    String _formatTime(int timestamp) {
      if (timestamp == 0) return "--:--";
      final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      final hour = date.hour > 12 ? date.hour - 12 : (date.hour == 0 ? 12 : date.hour);
      final min = date.minute.toString().padLeft(2, '0');
      final period = date.hour >= 12 ? 'PM' : 'AM';
      return "$hour:$min $period";
    }

    return WeatherModel(
      cityName: json['name'] ?? "Unknown",
      temperature: (main['temp'] as num).toDouble(),
      condition: weather['main'] ?? "Clear",
      humidity: (main['humidity'] as num).toInt(),
      windSpeed: (wind['speed'] as num).toDouble(),
      uvIndex: 0, // UV Index requires separate OneCall API in OWM 2.5
      pressure: (main['pressure'] as num).toInt(),
      sunrise: _formatTime(sys['sunrise'] ?? 0),
      sunset: _formatTime(sys['sunset'] ?? 0),
      forecastList: mockForecast,
    );
  }
}
