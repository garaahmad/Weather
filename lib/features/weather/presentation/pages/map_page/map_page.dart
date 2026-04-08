import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:globalweather/core/theme/colors.dart';
import 'package:globalweather/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:globalweather/features/location/presentation/bloc/location_bloc.dart';
import 'package:globalweather/features/location/presentation/bloc/location_state.dart';
import 'widgets/map.dart';
import 'widgets/map_button.dart';
import 'widgets/monitoring_dialog.dart';
import 'data/repositories/get_current_location.dart';

class WeatherMapPage extends StatefulWidget {
  const WeatherMapPage({super.key});
  @override
  State<WeatherMapPage> createState() => _WeatherMapPageState();
}

class _WeatherMapPageState extends State<WeatherMapPage> {
  final MapController _mapController = MapController();
  LatLng _selectedPoint = const LatLng(51.5074, -0.1278);
  String _locationName = "London, UK";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setInitialMapLocation();
    });
  }

  void _setInitialMapLocation() {
    final locState = context.read<LocationBloc>().state;
    if (locState is LocationLoaded) {
      _updateMap(LatLng(locState.location.latitude, locState.location.longitude), locState.location.cityName);
    } else if (locState is LocationUsedFromCache) {
      _updateMap(LatLng(locState.location.latitude, locState.location.longitude), locState.location.cityName);
    } else if (locState is LocationSilentlyUpdated) {
      _updateMap(LatLng(locState.location.latitude, locState.location.longitude), locState.location.cityName);
    } else {
      // Default to London if nothing is available, do NOT prompt user
      _updateMap(const LatLng(51.5074, -0.1278), "London, UK");
    }
  }

  void _updateMap(LatLng point, String name) {
    setState(() {
      _selectedPoint = point;
      _locationName = name.isEmpty ? "Saved Location" : name;
    });
    _mapController.move(_selectedPoint, 9.0);
  }

  Future<void> _getCurrentLocation({bool showDialog = false}) async {
    final position = await LocationRepository.getCurrentLocation();
    if (position != null && mounted) {
      final point = LatLng(position.latitude, position.longitude);
      _updateMap(point, "Your Location");
      
      if (showDialog) {
        showMonitoringDialog(context, point, () {
          context.read<WeatherCubit>().fetchWeatherByCoords(point.latitude, point.longitude);
        });
      }
    }
  }

  void _onPointSelected(LatLng point) {
    setState(() {
      _selectedPoint = point;
      _locationName =
          "${point.latitude.toStringAsFixed(2)}, ${point.longitude.toStringAsFixed(2)}";
    });
    showMonitoringDialog(context, point, () {
      context.read<WeatherCubit>().fetchWeatherByCoords(point.latitude, point.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: AppMap(
            mapController: _mapController,
            selectedPoint: _selectedPoint,
            onPointSelected: _onPointSelected,
          ),
        ),
        IgnorePointer(child: Container(color: Colors.black.withOpacity(0.4))),
        Positioned(
          top: 10,
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
        Positioned(
          right: 24,
          top: 200,
          child: Column(
            children: [
              buildMapFab(
                Icons.add,
                onTap: () {
                  _mapController.move(
                    _mapController.camera.center,
                    _mapController.camera.zoom + 1,
                  );
                },
              ),
              const SizedBox(height: 16),
              buildMapFab(
                Icons.remove,
                onTap: () {
                  _mapController.move(
                    _mapController.camera.center,
                    _mapController.camera.zoom - 1,
                  );
                },
              ),
              const SizedBox(height: 24),
              buildMapFab(
                Icons.my_location,
                isPrimary: true,
                onTap: () => _getCurrentLocation(showDialog: true),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
