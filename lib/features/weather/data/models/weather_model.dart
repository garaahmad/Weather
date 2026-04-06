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

    String _formatTime(int timestamp) {
      if (timestamp == 0) return "--:--";
      final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      final hour = date.hour > 12 ? date.hour - 12 : (date.hour == 0 ? 12 : date.hour);
      final min = date.minute.toString().padLeft(2, '0');
      final period = date.hour >= 12 ? 'PM' : 'AM';
      return "$hour:$min $period";
    }

    String name = json['name'] ?? "";
    if (name.isEmpty || name == "Unknown" || name.contains(RegExp(r'^\d'))) {
      final lat = json['coord']?['lat']?.toStringAsFixed(2) ?? "0";
      final lon = json['coord']?['lon']?.toStringAsFixed(2) ?? "0";
      name = "Your Location ($lat, $lon)";
    }

    return WeatherModel(
      cityName: name,
      temperature: (main['temp'] as num).toDouble(),
      condition: weather['main'] ?? "Clear",
      humidity: (main['humidity'] as num).toInt(),
      windSpeed: (wind['speed'] as num).toDouble(),
      uvIndex: 0, 
      pressure: (main['pressure'] as num).toInt(),
      sunrise: _formatTime(sys['sunrise'] ?? 0),
      sunset: _formatTime(sys['sunset'] ?? 0),
      forecastList: const [],
    );
  }

  factory WeatherModel.fromCombinedJson(Map<String, dynamic> currentJson, Map<String, dynamic> forecastJson) {
    final weather = WeatherModel.fromJson(currentJson);
    final List<dynamic> forecastListRaw = forecastJson['list'] ?? [];
    
    // Group forecast by day and take midday values (around 12:00)
    final List<ForecastModel> forecasts = [];
    final seenDays = <String>{};
    
    for (var item in forecastListRaw) {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000);
      final dayString = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
      
      // Take the midday forecast or the first one we find for a new day
      if (!seenDays.contains(dayString) && dateTime.hour >= 12) {
        forecasts.add(ForecastModel.fromJson(item));
        seenDays.add(dayString);
      }
    }

    return WeatherModel(
      cityName: weather.cityName,
      temperature: weather.temperature,
      condition: weather.condition,
      humidity: weather.humidity,
      windSpeed: weather.windSpeed,
      uvIndex: weather.uvIndex,
      pressure: weather.pressure,
      sunrise: weather.sunrise,
      sunset: weather.sunset,
      forecastList: forecasts,
    );
  }
}

class ForecastModel extends ForecastEntity {
  const ForecastModel({
    required super.date,
    required super.temperature,
    required super.low,
    required super.high,
    required super.condition,
    super.rainProbability,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    final main = json['main'];
    final weather = json['weather'][0];
    
    return ForecastModel(
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      temperature: (main['temp'] as num).toDouble(),
      low: (main['temp_min'] as num).toDouble(),
      high: (main['temp_max'] as num).toDouble(),
      condition: weather['main'] ?? "Clear",
      rainProbability: ((json['pop'] ?? 0) * 100).toInt(),
    );
  }
}
