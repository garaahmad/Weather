import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:globalweather/features/location/domain/entities/location_entity.dart';
import 'package:globalweather/features/location/domain/repositories/i_location_repository.dart';

class LocationRepositoryImpl implements ILocationRepository {
  static const _latKey = 'loc_lat';
  static const _lonKey = 'loc_lon';
  static const _nameKey = 'loc_name';
  static const _firstLaunchKey = 'first_launch_done';


  @override
  Future<bool> isLocationServiceEnabled() =>
      Geolocator.isLocationServiceEnabled();

  @override
  Future<bool> isPermissionGranted() async {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }


  @override
  Future<LocationEntity?> getCurrentLocation() async {
    // Check service
    final serviceOn = await Geolocator.isLocationServiceEnabled();
    if (!serviceOn) return null;

    // Check/request permission
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return null;
    }

    final pos = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 10),
      ),
    );

    return LocationEntity(
      latitude: pos.latitude,
      longitude: pos.longitude,
      cityName: '',
    );
  }


  @override
  Future<void> saveLocation(LocationEntity location) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_latKey, location.latitude);
    await prefs.setDouble(_lonKey, location.longitude);
    await prefs.setString(_nameKey, location.cityName);
  }

  @override
  Future<LocationEntity?> getSavedLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final lat = prefs.getDouble(_latKey);
    final lon = prefs.getDouble(_lonKey);
    final name = prefs.getString(_nameKey);
    if (lat == null || lon == null) return null;
    return LocationEntity(
      latitude: lat,
      longitude: lon,
      cityName: name ?? '',
    );
  }


  @override
  Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return !(prefs.getBool(_firstLaunchKey) ?? false);
  }

  @override
  Future<void> markFirstLaunchDone() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_firstLaunchKey, true);
  }
}
