import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:globalweather/features/location/domain/entities/location_entity.dart';
import 'package:globalweather/features/location/domain/repositories/i_location_repository.dart';
import 'package:globalweather/features/location/domain/usecases/location_usecases.dart';
import 'package:globalweather/features/location/data/services/fcm_topic_service.dart';
import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetCurrentLocationUseCase _getCurrentLocation;
  final SilentLocationCheckUseCase _silentLocationCheck;
  final GetSavedLocationUseCase _getSavedLocation;
  final SaveLocationUseCase _saveLocation;
  final FirstLaunchUseCase _firstLaunch;
  final FcmTopicService _fcmTopicService;

  LocationBloc({
    required ILocationRepository repository,
    required FcmTopicService fcmTopicService,
  })  : _fcmTopicService = fcmTopicService,
        _getCurrentLocation = GetCurrentLocationUseCase(repository),
        _silentLocationCheck = SilentLocationCheckUseCase(repository),
        _getSavedLocation = GetSavedLocationUseCase(repository),
        _saveLocation = SaveLocationUseCase(repository),
        _firstLaunch = FirstLaunchUseCase(repository),
        super(LocationInitial()) {
    on<AppLaunched>(_onAppLaunched);
    on<LocationPermissionGranted>(_onPermissionGranted);
    on<LocationPermissionDenied>(_onPermissionDenied);
    on<RefreshCurrentLocation>(_onRefreshCurrentLocation);
  }

  // ─── First launch vs Subsequent launch ───────────────────────────────────────

  Future<void> _onAppLaunched(
      AppLaunched event, Emitter<LocationState> emit) async {
    final isFirst = await _firstLaunch.isFirstLaunch();

    if (isFirst) {
      emit(LocationPermissionRequired());
      return;
    }

    // Subsequent launch: show cached data immediately
    final saved = await _getSavedLocation();
    if (saved != null) {
      emit(LocationUsedFromCache(saved));
    }

    // Then silently check GPS in background
    await _performSilentBackgroundUpdate(saved, emit);
  }

  // ─── First-launch permission granted ────────────────────────────────────────

  Future<void> _onPermissionGranted(
      LocationPermissionGranted event, Emitter<LocationState> emit) async {
    emit(LocationLoading());
    try {
      final location = await _getCurrentLocation();
      if (location == null) {
        emit(const LocationError('Could not retrieve location.'));
        return;
      }
      await _saveAndSubscribe(oldCity: null, newLocation: location, emit: emit);
      await _firstLaunch.markDone();
      emit(LocationLoaded(location: location, isLive: true));
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }

  // ─── First-launch permission denied ─────────────────────────────────────────

  Future<void> _onPermissionDenied(
      LocationPermissionDenied event, Emitter<LocationState> emit) async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      emit(LocationPermissionDeniedForever());
    } else {
      emit(LocationPermissionRequired());
    }
  }

  // ─── Manual refresh from Map page ───────────────────────────────────────────

  Future<void> _onRefreshCurrentLocation(
      RefreshCurrentLocation event, Emitter<LocationState> emit) async {
    emit(LocationLoading());
    try {
      final saved = await _getSavedLocation();
      final location = await _getCurrentLocation();
      if (location == null) {
        emit(const LocationError('Location service unavailable.'));
        return;
      }
      await _saveAndSubscribe(
          oldCity: saved?.cityName, newLocation: location, emit: emit);
      emit(LocationLoaded(location: location, isLive: true));
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }

  // ─── Helpers ─────────────────────────────────────────────────────────────────

  Future<void> _performSilentBackgroundUpdate(
      LocationEntity? cached, Emitter<LocationState> emit) async {
    try {
      final liveLocation = await _silentLocationCheck();
      if (liveLocation == null) return; // GPS off — use cache silently

      await _saveAndSubscribe(
          oldCity: cached?.cityName, newLocation: liveLocation, emit: emit);
      emit(LocationSilentlyUpdated(liveLocation));
    } catch (_) {
      // Silently fail — never interrupt the user on background ops
    }
  }

  Future<void> _saveAndSubscribe({
    required String? oldCity,
    required LocationEntity newLocation,
    required Emitter<LocationState> emit,
  }) async {
    await _saveLocation(newLocation);
    if (newLocation.cityName.isNotEmpty) {
      await _fcmTopicService.updateSubscription(
        oldCityName: oldCity,
        newCityName: newLocation.cityName,
      );
    }
  }
}
