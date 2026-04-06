import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:globalweather/features/weather/domain/usecases/get_weather.dart';
import 'package:globalweather/features/weather/presentation/cubit/weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final GetWeatherUseCase getWeatherUseCase;

  WeatherCubit({required this.getWeatherUseCase}) : super(WeatherInitial());

  Future<void> fetchWeather(String cityName) async {
    emit(WeatherLoading());
    try {
      final weather = await getWeatherUseCase.execute(cityName);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }

  Future<void> fetchWeatherByCoords(double lat, double lon) async {
    emit(WeatherLoading());
    try {
      final weather = await getWeatherUseCase.repository.getWeatherByCoords(lat, lon);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
