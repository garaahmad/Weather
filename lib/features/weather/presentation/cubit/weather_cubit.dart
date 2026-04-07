import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:globalweather/features/weather/domain/usecases/get_weather.dart';
import 'package:globalweather/features/weather/presentation/cubit/weather_state.dart';
import 'package:globalweather/features/weather/data/repositories/location_persistence_repository.dart';
import 'package:globalweather/features/weather/presentation/pages/map_page/data/repositories/get_current_location.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final GetWeatherUseCase getWeatherUseCase;

  WeatherCubit({required this.getWeatherUseCase}) : super(WeatherInitial());

  Future<void> fetchInitialWeather() async {
    emit(WeatherLoading());
    try {
      // 1. Try to get current coordinate position
      final position = await LocationRepository.getCurrentLocation();
      if (position != null) {
        await fetchWeatherByCoords(position.latitude, position.longitude);
        return;
      }

      // 2. Try to get last saved location
      final lastLocation = await LocationPersistenceRepository.getLastLocation();
      if (lastLocation != null) {
        await fetchWeatherByCoords(lastLocation['lat'], lastLocation['lon']);
        return;
      }

      // 3. Default to London
      await fetchWeather('London');
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }

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
      await LocationPersistenceRepository.saveLocation(lat, lon, weather.cityName);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
