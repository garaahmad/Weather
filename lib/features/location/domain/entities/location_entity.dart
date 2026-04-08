class LocationEntity {
  final double latitude;
  final double longitude;
  final String cityName;

  const LocationEntity({
    required this.latitude,
    required this.longitude,
    required this.cityName,
  });

  @override
  String toString() => 'LocationEntity($cityName, $latitude, $longitude)';
}
