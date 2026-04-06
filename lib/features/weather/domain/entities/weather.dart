class ForecastEntity {
  final DateTime date;
  final double temperature;
  final double low;
  final double high;
  final String condition;
  final int rainProbability;

  const ForecastEntity({
    required this.date,
    required this.temperature,
    required this.low,
    required this.high,
    required this.condition,
    this.rainProbability = 0,
  });
}

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
  final List<ForecastEntity> forecastList;

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
    required this.forecastList,
  });
}
