import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:globalweather/core/theme/colors.dart';
import 'package:globalweather/core/network/api_constants.dart';
import 'package:geolocator/geolocator.dart';

class WeatherMapPage extends StatefulWidget {
  const WeatherMapPage({super.key});

  @override
  State<WeatherMapPage> createState() => _WeatherMapPageState();
}

class _WeatherMapPageState extends State<WeatherMapPage> {
  final MapController _mapController = MapController();
  String _activeLayer = 'precipitation_new'; // Default layer
  LatLng _selectedPoint = const LatLng(51.5074, -0.1278); // Default: London
  String _locationName = "London, UK";

  final Map<String, String> _layers = {
    'Precipitation': 'precipitation_new',
    'Temperature': 'temp_new',
    'Wind': 'wind_new',
  };

  void _onLayerChanged(String layerKey) {
    setState(() {
      _activeLayer = _layers[layerKey]!;
    });
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _selectedPoint = LatLng(position.latitude, position.longitude);
      _locationName = "Your Location";
    });
    _mapController.move(_selectedPoint, 9.0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Real Flutter Map
        Positioned.fill(
          child: FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _selectedPoint,
              initialZoom: 9.0,
              onTap: (tapPosition, point) {
                setState(() {
                  _selectedPoint = point;
                  _locationName =
                      "${point.latitude.toStringAsFixed(2)}, ${point.longitude.toStringAsFixed(2)}";
                });
                print("Selected Point: ${point.latitude}, ${point.longitude}");
              },
            ),
            children: [
              // Base Layer (OSM) - Stylized with a dark filter in the build
              TileLayer(
                urlTemplate: ApiConstants.osmUrl,
                userAgentPackageName: 'com.globalweather.app',
              ),
              // Weather Overlay Layer (OWM)
              TileLayer(urlTemplate: ApiConstants.weatherTileUrl(_activeLayer)),
              // Selection Marker
              MarkerLayer(
                markers: [
                  Marker(
                    point: _selectedPoint,
                    width: 60,
                    height: 60,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.redAccent,
                      size: 40,
                      shadows: [Shadow(blurRadius: 10, color: Colors.black45)],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Darkened Map Filter Overlay (To match the dashboard aesthetic)
        IgnorePointer(child: Container(color: Colors.black.withOpacity(0.4))),

        // Layer Toggle Selector
        Positioned(
          top: 24,
          left: 16,
          right: 16,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.surfaceColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: _layers.keys
                    .map(
                      (key) => GestureDetector(
                        onTap: () => _onLayerChanged(key),
                        child: _buildToggleItem(
                          key,
                          isActive: _activeLayer == _layers[key],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),

        // Location Badge
        Positioned(
          top: 90,
          left: 24,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 10),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _locationName,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Legend Card
        Positioned(
          bottom: 120,
          left: 24,
          right: 24,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surfaceColor.withOpacity(0.9),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 20),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _layers.entries
                          .firstWhere((e) => e.value == _activeLayer)
                          .key
                          .toUpperCase(),
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: AppColors.textColorSecondary,
                      ),
                    ),
                    const Text(
                      'Live Forecast Tiles',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accentColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.layers, color: AppColors.primaryColor),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Low',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.textColorSecondary,
                                ),
                              ),
                              Text(
                                'Medium',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.textColorSecondary,
                                ),
                              ),
                              Text(
                                'High',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.textColorSecondary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Container(
                            height: 8,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              gradient: LinearGradient(
                                colors: _getLayerGradient(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Floating Controls
        Positioned(
          right: 24,
          top: 200,
          child: Column(
            children: [
              _buildMapFab(
                Icons.add,
                onTap: () {
                  _mapController.move(
                    _mapController.camera.center,
                    _mapController.camera.zoom + 1,
                  );
                },
              ),
              const SizedBox(height: 16),
              _buildMapFab(
                Icons.remove,
                onTap: () {
                  _mapController.move(
                    _mapController.camera.center,
                    _mapController.camera.zoom - 1,
                  );
                },
              ),
              const SizedBox(height: 24),
              _buildMapFab(
                Icons.my_location,
                isPrimary: true,
                onTap: _getCurrentLocation,
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Color> _getLayerGradient() {
    if (_activeLayer == 'temp_new') {
      return [
        Colors.blue,
        Colors.green,
        Colors.yellow,
        Colors.orange,
        Colors.red,
      ];
    } else if (_activeLayer == 'precipitation_new') {
      return [
        Colors.blue.withOpacity(0.1),
        Colors.blue,
        Colors.indigo,
        Colors.purple,
      ];
    } else {
      return [Colors.cyan.withOpacity(0.1), Colors.cyan, Colors.teal];
    }
  }

  Widget _buildToggleItem(String text, {bool isActive = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.primaryColor.withOpacity(0.2)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          color: isActive
              ? AppColors.primaryColor
              : AppColors.textColorSecondary,
        ),
      ),
    );
  }

  Widget _buildMapFab(
    IconData icon, {
    bool isPrimary = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: isPrimary
              ? AppColors.primaryColor
              : AppColors.surfaceColor.withOpacity(0.9),
          shape: isPrimary ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isPrimary ? null : BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: isPrimary ? Colors.white : AppColors.textColorPrimary,
        ),
      ),
    );
  }
}
