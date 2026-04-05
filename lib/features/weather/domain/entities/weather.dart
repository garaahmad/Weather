class WeatherEntity {
  final String cityName;
  final double temperature;
  final String condition;
  final int humidity;
  final double windSpeed;
  final int uvIndex;
  final int pressure;
  final String sunrise;
  final String sunset;

  const WeatherEntity({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.windSpeed,
    required this.uvIndex,
    required this.pressure,
    required this.sunrise,
    required this.sunset,
  });
}
