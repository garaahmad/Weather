import 'package:shared_preferences/shared_preferences.dart';

class LocationPersistenceRepository {
  static const String _latKey = 'last_lat';
  static const String _lonKey = 'last_lon';
  static const String _nameKey = 'last_name';

  static Future<void> saveLocation(double lat, double lon, String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_latKey, lat);
    await prefs.setDouble(_lonKey, lon);
    await prefs.setString(_nameKey, name);
  }

  static Future<Map<String, dynamic>?> getLastLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final lat = prefs.getDouble(_latKey);
    final lon = prefs.getDouble(_lonKey);
    final name = prefs.getString(_nameKey);

    if (lat != null && lon != null) {
      return {
        'lat': lat,
        'lon': lon,
        'name': name ?? 'Saved Location',
      };
    }
    return null;
  }
}
