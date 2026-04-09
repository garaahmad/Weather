import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:globalweather/core/theme/colors.dart';
import 'package:globalweather/core/widgets/app_bar_shared.dart';
import 'package:globalweather/core/widgets/app_drawer.dart';
import 'package:globalweather/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:globalweather/features/weather/presentation/cubit/weather_state.dart';
import 'package:globalweather/features/weather/presentation/pages/forecast_page/forecast_page.dart';
import 'package:globalweather/features/weather/presentation/pages/map_page/map_page.dart';
import 'package:globalweather/features/weather/presentation/pages/settings_page/settings_page.dart';
import 'package:globalweather/features/weather/presentation/widgets/current_temperature.dart';
import 'package:globalweather/features/weather/presentation/widgets/info_card.dart';
import 'package:globalweather/features/weather/presentation/widgets/precipitation_map.dart';
import 'package:globalweather/features/weather/presentation/widgets/scale_change.dart';
import 'package:globalweather/features/weather/presentation/widgets/search_bar.dart';
import 'package:globalweather/features/weather/presentation/widgets/weekly_forecast.dart';
import 'package:globalweather/features/weather/presentation/cubit/settings_cubit.dart';
import 'package:globalweather/features/weather/data/repositories/settings_repository.dart';

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
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          Positioned(
            top: -100.h,
            left: -100.w,
            child: Container(
              width: 300.w,
              height: 300.h,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const SizedBox.expand(),
            ),
          ),
          Positioned(
            top: 100.h,
            right: -100.w,
            child: Container(
              width: 250.w,
              height: 250.h,
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
    return RefreshIndicator(
      color: AppColors.accentColor,
      backgroundColor: AppColors.surfaceColor,
      onRefresh: () async {
        final weatherState = context.read<WeatherCubit>().state;
        if (weatherState is WeatherLoaded) {
          // Refresh the weather for the current city silently without prompting for GPS
          await context.read<WeatherCubit>().fetchWeather(weatherState.weather.cityName);
        } else {
          // If no weather loaded, maybe we can fetch initial or trigger location refresh
          // But we want to avoid location prompt if possible.
          // AppRouter takes care of the initial load.
        }
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            const SearchBarApp(),
            SizedBox(height: 16.h),
            BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, settingsState) {
                return TemperatureScaleToggle(
                  initialValue: settingsState.unit == TemperatureUnit.celsius,
                  onToggle: (isCelsius) {
                    context.read<SettingsCubit>().setTemperatureUnit(
                      isCelsius ? TemperatureUnit.celsius : TemperatureUnit.fahrenheit
                    );
                  },
                );
              },
            ),
            const CurrentTemperature(),
            SizedBox(height: 32.h),
            BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                // Show sunrise/sunset cards for loaded OR offline-with-cached-data states
                final weather = state is WeatherLoaded
                    ? state.weather
                    : (state is WeatherNoConnection ? state.lastWeather : null);
                if (weather != null) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: InfoCard(
                            icon: Icons.wb_twilight_rounded,
                            title: 'SUNRISE',
                            value: weather.sunrise,
                            iconColor: AppColors.secondaryColor,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: InfoCard(
                            icon: Icons.bedtime_rounded,
                            title: 'SUNSET',
                            value: weather.sunset,
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
            SizedBox(height: 32.h),
            const WeeklyForecast(),
            SizedBox(height: 32.h),
            const PrecipitationMap(),
            SizedBox(height: 120.h), // Extra padding for bottom nav
          ],
        ),
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
        borderRadius: BorderRadius.vertical(top: Radius.circular(36.r)),
        child: BottomNavigationBar(
          //////////////////////////////////////////////////////////////// Change Here
          backgroundColor: _currentIndex == 2 
              ? Colors.black.withOpacity(0.4) 
              : Colors.blue.withOpacity(0.14),
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


