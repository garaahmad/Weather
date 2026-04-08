import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:globalweather/features/location/presentation/bloc/location_bloc.dart';
import 'package:globalweather/features/location/presentation/bloc/location_event.dart';
import 'package:globalweather/features/location/presentation/bloc/location_state.dart';
import 'package:globalweather/features/location/presentation/pages/location_permission_page.dart';
import 'package:globalweather/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:globalweather/features/weather/presentation/pages/weather_page/weather_page.dart';

/// Root widget that listens to [LocationBloc] and orchestrates routing.
/// - First launch → [LocationPermissionPage]
/// - Loaded → [WeatherPage] (fetches weather from resolved coords)
/// - Silent update → triggers weather refresh quietly
class AppRouter extends StatefulWidget {
  const AppRouter({super.key});

  @override
  State<AppRouter> createState() => _AppRouterState();
}

class _AppRouterState extends State<AppRouter> {
  @override
  void initState() {
    super.initState();
    // Kick off the launch logic
    context.read<LocationBloc>().add(AppLaunched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationBloc, LocationState>(
      listener: (context, state) {
        if (state is LocationLoaded) {
          // Fetch weather with the newly resolved live location
          context.read<WeatherCubit>().fetchWeatherByCoords(
                state.location.latitude,
                state.location.longitude,
              );
        } else if (state is LocationSilentlyUpdated) {
          // Silent background GPS refresh — update weather quietly
          context.read<WeatherCubit>().fetchWeatherByCoords(
                state.location.latitude,
                state.location.longitude,
              );
        } else if (state is LocationUsedFromCache) {
          // Warm start with cached coords immediately
          context.read<WeatherCubit>().fetchWeatherByCoords(
                state.location.latitude,
                state.location.longitude,
              );
        }
      },
      child: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          // First-launch permission request
          if (state is LocationPermissionRequired) {
            return const LocationPermissionPage();
          }

          // Permission permanently denied — show settings prompt
          if (state is LocationPermissionDeniedForever) {
            return const _DeniedForeverPage();
          }

          // Everything else (loading, loaded, cache, silent update)
          // → show main weather page
          return const WeatherPage();
        },
      ),
    );
  }
}

/// Shown only when permission is permanently denied.
class _DeniedForeverPage extends StatelessWidget {
  const _DeniedForeverPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1120),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_off, size: 64, color: Colors.red),
              const SizedBox(height: 24),
              const Text(
                'Location Access Required',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Please enable location permission in your device settings to continue using GlobalWeather.',
                style: TextStyle(color: Colors.white60, height: 1.6),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () async {
                  await Future.delayed(const Duration(milliseconds: 100));
                  if (context.mounted) {
                    context.read<LocationBloc>().add(AppLaunched());
                  }
                },
                icon: const Icon(Icons.settings),
                label: const Text('Open Settings'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
