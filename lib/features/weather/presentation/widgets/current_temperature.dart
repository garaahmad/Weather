import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:globalweather/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:globalweather/features/weather/presentation/cubit/weather_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:globalweather/features/weather/presentation/widgets/state_card.dart';
import 'package:globalweather/features/weather/presentation/cubit/settings_cubit.dart';
import 'package:globalweather/core/utils/temperature_converter.dart';
import 'package:globalweather/core/widgets/offline_widget.dart';
import 'package:globalweather/features/weather/domain/entities/weather.dart';

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
          return _buildWeatherContent(context, state.weather);
        } else if (state is WeatherNoConnection) {
          // If we have cached data, show it with a subtle offline banner
          if (state.lastWeather != null) {
            return Column(
              children: [
                const OfflineWidget(compact: true),
                _buildWeatherContent(context, state.lastWeather!),
              ],
            );
          }
          // No cached data at all — show full offline page
          return OfflineWidget(
            onRetry: () => context.read<WeatherCubit>().fetchInitialWeather(),
          );
        } else if (state is WeatherError) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(32.w),
              child: Column(
                children: [
                  Icon(Icons.error_outline, size: 48.sp, color: Colors.white38),
                  SizedBox(height: 16.h),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildWeatherContent(BuildContext context, WeatherEntity weather) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            weather.cityName,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, settingsState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    TemperatureConverter.format(weather.temperature, settingsState.unit),
                    style: TextStyle(
                      fontSize: 64.sp,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Icon(
                    _getWeatherIcon(weather.condition),
                    size: 48.sp,
                    color: Colors.blueAccent,
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 16.h),
          Text(
            weather.condition,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: 48.h),
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
                SizedBox(width: 16.w),
                WeatherStateCard(
                  icon: Icons.air,
                  title: 'WIND',
                  value: weather.windSpeed.toString(),
                  unit: ' km/h',
                ),
                SizedBox(width: 16.w),
                WeatherStateCard(
                  icon: Icons.wb_sunny_outlined,
                  title: 'UV INDEX',
                  value: weather.uvIndex.toString(),
                ),
                SizedBox(width: 16.w),
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
