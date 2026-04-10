import 'package:globalweather/features/location/domain/entities/location_entity.dart';

abstract class ILocationRepository {
  Future<LocationEntity?> getCurrentLocation();

  Future<bool> isLocationServiceEnabled();

  Future<bool> isPermissionGranted();

  Future<void> saveLocation(LocationEntity location);

  Future<LocationEntity?> getSavedLocation();

  Future<bool> isFirstLaunch();

  Future<void> markFirstLaunchDone();

  Future<bool> openLocationSettings();
}
