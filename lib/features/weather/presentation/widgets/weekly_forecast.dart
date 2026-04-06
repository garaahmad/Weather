import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:globalweather/core/theme/colors.dart';
import 'package:globalweather/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:globalweather/features/weather/presentation/cubit/weather_state.dart';
import 'package:intl/intl.dart';

class WeeklyForecast extends StatelessWidget {
  const WeeklyForecast({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoaded) {
          final forecast = state.weather.forecastList.take(3).toList();
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surfaceColor.withOpacity(0.4),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '3-DAY FORECAST',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: AppColors.textColorSecondary,
                  ),
                ),
                const SizedBox(height: 24),
                ...forecast.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  final isLast = index == forecast.length - 1;
                  
                  return Column(
                    children: [
                      _ForecastRow(
                        day: index == 0 ? 'Today' : DateFormat('EEE').format(item.date),
                        icon: _getWeatherIcon(item.condition),
                        iconColor: item.condition.contains('Rain') ? AppColors.primaryColor : AppColors.secondaryColor,
                        low: '${item.low.round()}°',
                        high: '${item.high.round()}°',
                        gradientStops: [0.2, 0.8],
                      ),
                      if (!isLast) const Divider(height: 32, color: Colors.white10),
                    ],
                  );
                }).toList(),
              ],
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

class _ForecastRow extends StatelessWidget {
  final String day;
  final IconData icon;
  final Color iconColor;
  final String low;
  final String high;
  final List<double> gradientStops;

  const _ForecastRow({
    required this.day,
    required this.icon,
    required this.iconColor,
    required this.low,
    required this.high,
    required this.gradientStops,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 50,
          child: Text(
            day,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textColorPrimary,
            ),
          ),
        ),
        Icon(icon, color: iconColor, size: 24),
        const SizedBox(width: 16),
        Text(
          low,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textColorSecondary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: gradientStops[1] - gradientStops[0] + 0.2,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primaryColor, AppColors.secondaryColor],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          high,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.textColorPrimary,
          ),
        ),
      ],
    );
  }
}
