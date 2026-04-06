import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:globalweather/core/theme/colors.dart';
import 'package:globalweather/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:globalweather/features/weather/presentation/cubit/weather_state.dart';
import 'package:globalweather/features/weather/presentation/pages/forecast_page/widgets/detailed_outlook.dart';
import 'package:globalweather/features/weather/presentation/pages/forecast_page/widgets/forecast_row.dart';
import 'package:globalweather/features/weather/presentation/widgets/state_card.dart';
import 'package:intl/intl.dart';

class ForecastPage extends StatelessWidget {
  const ForecastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
           return const Center(child: CircularProgressIndicator(color: Colors.white));
        } else if (state is WeatherLoaded) {
          final weather = state.weather;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DetailedOutlook(weather: weather),
                    const SizedBox(width: 16),
                    WeatherStateCard(
                      icon: _getWeatherIcon(weather.condition),
                      title: '${weather.temperature.round()}°',
                      value: '/ ${weather.forecastList.isNotEmpty ? weather.forecastList[0].low.round() : "--"}°',
                      color: AppColors.secondaryColor,
                    ),
                  ],
                ),
                const SizedBox(height: 48),
                ...weather.forecastList.asMap().entries.map((entry) {
                   final index = entry.key;
                   final item = entry.value;
                   return Padding(
                     padding: const EdgeInsets.only(bottom: 16),
                     child: ForecastRow(
                        day: index == 0 ? 'Today' : DateFormat('EEE').format(item.date),
                        date: DateFormat('MMM d').format(item.date).toUpperCase(),
                        rain: '${item.rainProbability}%',
                        condition: item.condition,
                        icon: _getWeatherIcon(item.condition),
                        iconColor: item.condition.contains('Rain') ? AppColors.primaryColor : AppColors.secondaryColor,
                        low: item.low.round(),
                        high: item.high.round(),
                        isToday: index == 0,
                      ),
                   );
                }).toList(),
                const SizedBox(height: 100), // Reserve space for bottom nav
              ],
            ),
          );
        }
        return const Center(child: Text("Select a location to see forecast", style: TextStyle(color: Colors.white70)));
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
