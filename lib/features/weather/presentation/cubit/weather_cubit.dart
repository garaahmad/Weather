import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:globalweather/core/network/network_info.dart';
import 'package:globalweather/features/weather/domain/entities/weather.dart';
import 'package:globalweather/features/weather/domain/usecases/get_weather.dart';
import 'package:globalweather/features/weather/presentation/cubit/weather_state.dart';
import 'package:globalweather/features/weather/data/repositories/location_persistence_repository.dart';
import 'package:globalweather/features/weather/presentation/pages/map_page/data/repositories/get_current_location.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final GetWeatherUseCase getWeatherUseCase;

  /// Cached last successfully loaded weather — used to show stale data offline.
  WeatherEntity? _lastWeather;

  /// Remembers what the last fetch request was so we can auto-retry it.
  _LastFetchRequest? _lastRequest;

  StreamSubscription? _connectivitySub;

  WeatherCubit({required this.getWeatherUseCase}) : super(WeatherInitial()) {
    _listenToConnectivity();
  }

  // ─── Connectivity listener ──────────────────────────────────────────

  void _listenToConnectivity() {
    _connectivitySub = NetworkInfo.onConnectivityChanged.listen((result) async {
      // When connectivity comes back and we're in NoConnection state → auto-retry
      if (!result.contains(ConnectivityResult.none) &&
          state is WeatherNoConnection) {
        // Small delay to let the network stabilize
        await Future.delayed(const Duration(seconds: 1));
        _retryLastRequest();
      }
    });
  }

  void _retryLastRequest() {
    final req = _lastRequest;
    if (req == null) return;

    switch (req.type) {
      case _FetchType.initial:
        fetchInitialWeather();
        break;
      case _FetchType.byCity:
        fetchWeather(req.cityName!);
        break;
      case _FetchType.byCoords:
        fetchWeatherByCoords(req.lat!, req.lon!);
        break;
    }
  }

  // ─── Public fetch methods ──────────────────────────────────────────

  Future<void> fetchInitialWeather() async {
    _lastRequest = _LastFetchRequest(type: _FetchType.initial);
    emit(WeatherLoading());

    // Quick connectivity gate — skip the HTTP call entirely if offline
    if (!await NetworkInfo.isConnected()) {
      emit(WeatherNoConnection(lastWeather: _lastWeather));
      return;
    }

    try {
      // 1. Try current GPS location
      final position = await LocationRepository.getCurrentLocation();
      if (position != null) {
        await fetchWeatherByCoords(position.latitude, position.longitude);
        return;
      }

      // 2. Try last saved location
      final lastLocation = await LocationPersistenceRepository.getLastLocation();
      if (lastLocation != null) {
        await fetchWeatherByCoords(lastLocation['lat'], lastLocation['lon']);
        return;
      }

      // 3. Default to London
      await fetchWeather('London');
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> fetchWeather(String cityName) async {
    _lastRequest = _LastFetchRequest(type: _FetchType.byCity, cityName: cityName);
    emit(WeatherLoading());

    if (!await NetworkInfo.isConnected()) {
      emit(WeatherNoConnection(lastWeather: _lastWeather));
      return;
    }

    try {
      final weather = await getWeatherUseCase.execute(cityName);
      _lastWeather = weather;
      emit(WeatherLoaded(weather));
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> fetchWeatherByCoords(double lat, double lon) async {
    _lastRequest = _LastFetchRequest(type: _FetchType.byCoords, lat: lat, lon: lon);
    emit(WeatherLoading());

    if (!await NetworkInfo.isConnected()) {
      emit(WeatherNoConnection(lastWeather: _lastWeather));
      return;
    }

    try {
      final weather = await getWeatherUseCase.repository.getWeatherByCoords(lat, lon);
      await LocationPersistenceRepository.saveLocation(lat, lon, weather.cityName);
      _lastWeather = weather;
      emit(WeatherLoaded(weather));
    } catch (e) {
      _handleError(e);
    }
  }

  // ─── Error handling ────────────────────────────────────────────────

  void _handleError(Object e) {
    // Classify all network-related exceptions as "no connection"
    if (_isNetworkError(e)) {
      emit(WeatherNoConnection(lastWeather: _lastWeather));
    } else {
      // Truly unexpected errors (API returned 4xx, JSON parse, etc.)
      // Still show a user-friendly message instead of raw exception text
      emit(WeatherError(_friendlyMessage(e)));
    }
  }

  bool _isNetworkError(Object e) {
    if (e is SocketException) return true;
    if (e is TimeoutException) return true;
    if (e is HttpException) return true;
    final msg = e.toString().toLowerCase();
    return msg.contains('socketexception') ||
        msg.contains('failed host lookup') ||
        msg.contains('connection refused') ||
        msg.contains('connection reset') ||
        msg.contains('connection closed') ||
        msg.contains('connection timed out') ||
        msg.contains('handshake') ||
        msg.contains('network is unreachable') ||
        msg.contains('no address associated') ||
        msg.contains('clientexception');
  }

  String _friendlyMessage(Object e) {
    final msg = e.toString();
    if (msg.contains('404') || msg.contains('city not found')) {
      return 'City not found. Please check the name and try again.';
    }
    if (msg.contains('401')) {
      return 'Service authentication error. Please try later.';
    }
    return 'Something went wrong. Pull down to refresh.';
  }

  // ─── Cleanup ───────────────────────────────────────────────────────

  @override
  Future<void> close() {
    _connectivitySub?.cancel();
    return super.close();
  }
}

// ─── Internal helpers ──────────────────────────────────────────────────

enum _FetchType { initial, byCity, byCoords }

class _LastFetchRequest {
  final _FetchType type;
  final String? cityName;
  final double? lat;
  final double? lon;

  const _LastFetchRequest({
    required this.type,
    this.cityName,
    this.lat,
    this.lon,
  });
}
