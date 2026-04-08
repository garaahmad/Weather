import 'package:equatable/equatable.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();
  @override
  List<Object?> get props => [];
}

/// Fired on every app launch — decides first-launch vs subsequent-launch logic.
class AppLaunched extends LocationEvent {}

/// User tapped "Allow" on the permission screen.
class LocationPermissionGranted extends LocationEvent {}

/// User tapped "Deny" on the first-launch permission screen.
class LocationPermissionDenied extends LocationEvent {}

/// Triggered from Map page — user wants to lock to current GPS location.
class RefreshCurrentLocation extends LocationEvent {}
