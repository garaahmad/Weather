import 'package:globalweather/features/location/domain/entities/location_entity.dart';

abstract class ILocationRepository {
  /// Request location permission and get current position.
  /// Returns null if permission denied or GPS is off.
  Future<LocationEntity?> getCurrentLocation();

  /// Check if GPS is enabled, without requesting permission or showing popups.
  Future<bool> isLocationServiceEnabled();

  /// Check if permission is already granted (no dialog shown).
  Future<bool> isPermissionGranted();

  /// Save location to local storage.
  Future<void> saveLocation(LocationEntity location);

  /// Retrieve the last saved location from local storage.
  Future<LocationEntity?> getSavedLocation();

  /// Check if this is the first launch of the app.
  Future<bool> isFirstLaunch();

  /// Mark that the first launch setup has been completed.
  Future<void> markFirstLaunchDone();
}
