import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:globalweather/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:globalweather/features/weather/presentation/cubit/weather_state.dart';
import 'package:globalweather/features/weather/presentation/widgets/state_card.dart';

class CurrentTemperature extends StatelessWidget {
  const CurrentTemperature({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        } else if (state is WeatherLoaded) {
          final weather = state.weather;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  weather.cityName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${weather.temperature.round()}°C',
                      style: const TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      _getWeatherIcon(weather.condition),
                      size: 48,
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  weather.condition,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 48),
                // Horizontal scrolling list of state cards
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      WeatherStateCard(
                        icon: Icons.water_drop_outlined,
                        title: 'HUMIDITY',
                        value: weather.humidity.toString(),
                        unit: '%',
                      ),
                      const SizedBox(width: 16),
                      WeatherStateCard(
                        icon: Icons.air,
                        title: 'WIND',
                        value: weather.windSpeed.toString(),
                        unit: ' km/h',
                      ),
                      const SizedBox(width: 16),
                      WeatherStateCard(
                        icon: Icons.wb_sunny_outlined,
                        title: 'UV INDEX',
                        value: weather.uvIndex.toString(),
                      ),
                      const SizedBox(width: 16),
                      WeatherStateCard(
                        icon: Icons.speed,
                        title: 'PRESSURE',
                        value: weather.pressure.toString(),
                        unit: ' hPa',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (state is WeatherError) {
          return Center(
            child: Text(
              "Error: ${state.message}",
              style: const TextStyle(color: Colors.redAccent),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  IconData _getWeatherIcon(String condition) {
    if (condition.contains('Cloud')) return Icons.wb_cloudy_outlined;
    if (condition.contains('Rain')) return Icons.beach_access_rounded;
    if (condition.contains('Sun') || condition.contains('Clear')) {
      return Icons.wb_sunny_outlined;
    }
    return Icons.cloud_outlined;
  }
}
