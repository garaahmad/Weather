import 'package:globalweather/features/location/domain/entities/location_entity.dart';
import 'package:globalweather/features/location/domain/repositories/i_location_repository.dart';

/// Use case: Get current GPS location (requests permission if needed).
class GetCurrentLocationUseCase {
  final ILocationRepository repository;
  GetCurrentLocationUseCase(this.repository);

  Future<LocationEntity?> call() => repository.getCurrentLocation();
}

/// Use case: Silently check GPS and return current location without any popup.
class SilentLocationCheckUseCase {
  final ILocationRepository repository;
  SilentLocationCheckUseCase(this.repository);

  Future<LocationEntity?> call() async {
    final serviceOn = await repository.isLocationServiceEnabled();
    if (!serviceOn) return null;

    final permitted = await repository.isPermissionGranted();
    if (!permitted) return null;

    return repository.getCurrentLocation();
  }
}

/// Use case: Get the last saved (cached) location.
class GetSavedLocationUseCase {
  final ILocationRepository repository;
  GetSavedLocationUseCase(this.repository);

  Future<LocationEntity?> call() => repository.getSavedLocation();
}

/// Use case: Save a location to local storage.
class SaveLocationUseCase {
  final ILocationRepository repository;
  SaveLocationUseCase(this.repository);

  Future<void> call(LocationEntity location) => repository.saveLocation(location);
}

/// Use case: Check and mark first launch.
class FirstLaunchUseCase {
  final ILocationRepository repository;
  FirstLaunchUseCase(this.repository);

  Future<bool> isFirstLaunch() => repository.isFirstLaunch();
  Future<void> markDone() => repository.markFirstLaunchDone();
}
