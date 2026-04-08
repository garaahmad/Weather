import 'package:equatable/equatable.dart';
import 'package:globalweather/features/location/domain/entities/location_entity.dart';

abstract class LocationState extends Equatable {
  const LocationState();
  @override
  List<Object?> get props => [];
}

/// Initial state before any location logic runs.
class LocationInitial extends LocationState {}

/// Shown only on first launch — awaiting user permission grant.
class LocationPermissionRequired extends LocationState {}

/// User hard-denied permissions (deniedForever).
class LocationPermissionDeniedForever extends LocationState {}

/// Location is being fetched / processed.
class LocationLoading extends LocationState {}

/// Successfully resolved a location.
class LocationLoaded extends LocationState {
  final LocationEntity location;
  /// True if the location was fetched live; false if served from cache.
  final bool isLive;

  const LocationLoaded({required this.location, required this.isLive});

  @override
  List<Object?> get props => [location.latitude, location.longitude, isLive];
}

/// A silent background update completed — UI does not need to react visually.
class LocationSilentlyUpdated extends LocationState {
  final LocationEntity location;
  const LocationSilentlyUpdated(this.location);

  @override
  List<Object?> get props => [location.latitude, location.longitude];
}

/// GPS was off on a subsequent launch; cached location is being used silently.
class LocationUsedFromCache extends LocationState {
  final LocationEntity location;
  const LocationUsedFromCache(this.location);

  @override
  List<Object?> get props => [location.latitude, location.longitude];
}

/// An error occurred during location resolution.
class LocationError extends LocationState {
  final String message;
  const LocationError(this.message);

  @override
  List<Object?> get props => [message];
}
