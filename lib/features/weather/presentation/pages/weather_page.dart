import 'package:flutter/material.dart';
import 'package:globalweather/core/theming/colors.dart';
import 'package:globalweather/core/widgets/app_bar_shared.dart';
import 'package:globalweather/features/weather/presentation/widgets/current_temperature.dart';
import 'package:globalweather/features/weather/presentation/widgets/precipitation_map.dart';
import 'package:globalweather/features/weather/presentation/widgets/scale_change.dart';
import 'package:globalweather/features/weather/presentation/widgets/search_bar.dart';
import 'package:globalweather/features/weather/presentation/widgets/weekly_forecast.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomSharedAppBar(title: "GlobalWeather"),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(-0.8, -0.7),
            radius: 1.5,
            colors: [
              Color(0xFF1FAAEF),
              AppColors.backgroundColor,
            ],
            stops: [0.0, 0.7],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SearchBarApp(),
              const SizedBox(height: 16),
              TemperatureScaleToggle(onToggle: (isCelsius) {}),
              const CurrentTemperature(),
              const SizedBox(height: 32),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InfoCard(
                        icon: Icons.wb_twilight_rounded,
                        title: 'SUNRISE',
                        value: '6:15 AM',
                        iconColor: AppColors.secondaryColor,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: InfoCard(
                        icon: Icons.bedtime_rounded,
                        title: 'SUNSET',
                        value: '8:30 PM',
                        iconColor: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const WeeklyForecast(),
              const SizedBox(height: 32),
              const PrecipitationMap(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 40,
              offset: const Offset(0, -10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          child: BottomNavigationBar(
            backgroundColor: const Color(0xFF0F172A).withOpacity(0.8),
            type: BottomNavigationBarType.fixed,
            elevation: 9,
            selectedItemColor: AppColors.accentColor,
            unselectedItemColor: Colors.white54,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.wb_sunny_outlined),
                label: 'TODAY',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined),
                label: 'FORECAST',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map_outlined),
                label: 'MAP',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: 'SETTINGS',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color iconColor;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.iconColor = Colors.blueAccent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withOpacity(0.4),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Colors.white54,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
