class ApiConstants {
  static const String apiKey = 'ca9688d365922fac248edc93686717cf';
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5/';
  
  // Weather Map Tiles
  static String weatherTileUrl(String layer) => 
      'https://tile.openweathermap.org/map/$layer/{z}/{x}/{y}.png?appid=$apiKey';

  // Base Map Layer (OpenStreetMap)
  static const String osmUrl = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
}
