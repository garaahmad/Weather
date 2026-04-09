import 'package:equatable/equatable.dart';
import 'package:globalweather/features/weather/domain/entities/weather.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherEntity weather;
  const WeatherLoaded(this.weather);

  @override
  List<Object?> get props => [weather];
}

class WeatherError extends WeatherState {
  final String message;
  const WeatherError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Emitted when there is no internet connection.
/// [lastWeather] holds previously loaded data (if any) so the UI
/// can still show stale data with a subtle "offline" banner instead
/// of a blank screen.
class WeatherNoConnection extends WeatherState {
  final WeatherEntity? lastWeather;
  const WeatherNoConnection({this.lastWeather});

  @override
  List<Object?> get props => [lastWeather];
}
