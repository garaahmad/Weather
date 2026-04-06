import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:globalweather/core/theme/colors.dart';
import 'package:globalweather/core/widgets/app_bar_shared.dart';
import 'package:globalweather/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:globalweather/features/weather/presentation/cubit/weather_state.dart';
import 'package:globalweather/features/weather/presentation/pages/forecast_page/forecast_page.dart';
import 'package:globalweather/features/weather/presentation/pages/map_page.dart';
import 'package:globalweather/features/weather/presentation/pages/settings_page/settings_page.dart';
import 'package:globalweather/features/weather/presentation/widgets/current_temperature.dart';
import 'package:globalweather/features/weather/presentation/widgets/info_card.dart';
import 'package:globalweather/features/weather/presentation/widgets/precipitation_map.dart';
import 'package:globalweather/features/weather/presentation/widgets/scale_change.dart';
import 'package:globalweather/features/weather/presentation/widgets/search_bar.dart';
import 'package:globalweather/features/weather/presentation/widgets/weekly_forecast.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      extendBody: true,
      appBar: const CustomSharedAppBar(title: "GlobalWeather"),
      body: Stack(
        children: [
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const SizedBox.expand(),
            ),
          ),
          Positioned(
            top: 100,
            right: -100,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(-0.8, -0.7),
                radius: 1.5,
                colors: [Color(0xFF1FAAEF), AppColors.backgroundColor],
                stops: [0.0, 0.7],
              ),
            ),
            child: IndexedStack(
              index: _currentIndex,
              children: [
                _buildTodayView(context),
                const ForecastPage(),
                const WeatherMapPage(),
                const WeatherSettingsPage(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildTodayView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SearchBarApp(),
          const SizedBox(height: 16),
          TemperatureScaleToggle(onToggle: (isCelsius) {}),
          const CurrentTemperature(),
          const SizedBox(height: 32),
          BlocBuilder<WeatherCubit, WeatherState>(
            builder: (context, state) {
              if (state is WeatherLoaded) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InfoCard(
                          icon: Icons.wb_twilight_rounded,
                          title: 'SUNRISE',
                          value: state.weather.sunrise,
                          iconColor: AppColors.secondaryColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: InfoCard(
                          icon: Icons.bedtime_rounded,
                          title: 'SUNSET',
                          value: state.weather.sunset,
                          iconColor: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          const SizedBox(height: 32),
          const WeeklyForecast(),
          const SizedBox(height: 32),
          const PrecipitationMap(),
          const SizedBox(height: 120),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
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
        borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
        child: BottomNavigationBar(
          backgroundColor: Colors.blue.withOpacity(0.14),
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          elevation: 0,
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
    );
  }
}


