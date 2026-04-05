import 'package:flutter/material.dart';
import 'package:globalweather/features/weather/presentation/widgets/state_card.dart';

class CurrentTemperature extends StatefulWidget {
  const CurrentTemperature({super.key});

  @override
  State<CurrentTemperature> createState() => _CurrentTemperatureState();
}

class _CurrentTemperatureState extends State<CurrentTemperature> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'New York, US',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '25°C',
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(
                Icons.wb_cloudy_outlined,
                size: 48,
                color: Colors.blueAccent,
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Partly Cloudy skies will persist until evening",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.thermostat_outlined,
                size: 24,
                color: Colors.blueAccent,
              ),
              const SizedBox(width: 8),
              const Text(
                "Feels like 20°",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          // Horizontal scrolling list of state cards
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const WeatherStateCard(
                  icon: Icons.water_drop_outlined,
                  title: 'HUMIDITY',
                  value: '65',
                  unit: '%',
                ),
                const SizedBox(width: 16),
                const WeatherStateCard(
                  icon: Icons.air,
                  title: 'WIND',
                  value: '12',
                  unit: ' km/h',
                ),
                const SizedBox(width: 16),
                const WeatherStateCard(
                  icon: Icons.wb_sunny_outlined,
                  title: 'UV INDEX',
                  value: '4',
                ),
                const SizedBox(width: 16),
                const WeatherStateCard(
                  icon: Icons.speed,
                  title: 'PRESSURE',
                  value: '1012',
                  unit: ' hPa',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
