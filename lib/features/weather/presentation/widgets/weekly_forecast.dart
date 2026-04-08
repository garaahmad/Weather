import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:globalweather/core/theme/colors.dart';
import 'package:globalweather/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:globalweather/features/weather/presentation/cubit/weather_state.dart';
import 'package:globalweather/features/weather/presentation/cubit/settings_cubit.dart';
import 'package:globalweather/features/weather/data/repositories/settings_repository.dart';
import 'package:globalweather/core/utils/temperature_converter.dart';

class WeeklyForecast extends StatelessWidget {
  const WeeklyForecast({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, weatherState) {
        if (weatherState is! WeatherLoaded) return const SizedBox.shrink();
        
        final forecastList = weatherState.weather.forecastList;

        return BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, settingsState) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: AppColors.surfaceColor.withOpacity(0.4),
                borderRadius: BorderRadius.circular(32.r),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '7-DAY FORECAST',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: AppColors.textColorSecondary,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ...forecastList.asMap().entries.map((entry) {
                    final index = entry.key;
                    final forecast = entry.value;
                    final dayLabel = index == 0 ? 'Today' : _getDayName(forecast.date);
                    
                    return Column(
                      children: [
                        _ForecastRow(
                          day: dayLabel,
                          icon: _getWeatherIcon(forecast.condition),
                          iconColor: _getIconColor(forecast.condition),
                          low: forecast.low,
                          high: forecast.high,
                          unit: settingsState.unit,
                          gradientStops: const [0.2, 0.8],
                        ),
                        if (index < forecastList.length - 1)
                          Divider(height: 32.h, color: Colors.white10),
                      ],
                    );
                  }).toList(),
                ],
              ),
            );
          },
        );
      },
    );
  }

  String _getDayName(DateTime date) {
    final now = DateTime.now();
    if (date.day == now.day) return 'Today';
    // Simple day name formatting (could use intl package if available)
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }

  IconData _getWeatherIcon(String condition) {
    if (condition.contains('Cloud')) return Icons.wb_cloudy_outlined;
    if (condition.contains('Rain')) return Icons.beach_access_outlined;
    if (condition.contains('Sun') || condition.contains('Clear')) {
      return Icons.wb_sunny_outlined;
    }
    return Icons.cloud_outlined;
  }

  Color _getIconColor(String condition) {
    if (condition.contains('Sun') || condition.contains('Clear')) return AppColors.secondaryColor;
    if (condition.contains('Rain')) return AppColors.primaryColor;
    return AppColors.textColorSecondary;
  }
}

class _ForecastRow extends StatelessWidget {
  final String day;
  final IconData icon;
  final Color iconColor;
  final double low;
  final double high;
  final TemperatureUnit unit;
  final List<double> gradientStops;

  const _ForecastRow({
    required this.day,
    required this.icon,
    required this.iconColor,
    required this.low,
    required this.high,
    required this.unit,
    required this.gradientStops,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 50.w,
          child: Text(
            day,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textColorPrimary,
            ),
          ),
        ),
        Icon(icon, color: iconColor, size: 24.sp),
        SizedBox(width: 16.w),
        Text(
          TemperatureConverter.format(low, unit),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textColorSecondary,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Container(
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(2.r),
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
        SizedBox(width: 12.w),
        Text(
          TemperatureConverter.format(high, unit),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textColorPrimary,
          ),
        ),
      ],
    );
  }
}
