import 'package:flutter/material.dart';
import 'package:globalweather/core/theme/colors.dart';
import 'package:globalweather/features/weather/domain/entities/weather.dart';

class DetailedOutlook extends StatelessWidget {
  final WeatherEntity weather;
  const DetailedOutlook({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'DETAILED OUTLOOK',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Next ${weather.forecastList.length} Days',
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w900,
              letterSpacing: -2.0,
              height: 1.0,
              color: AppColors.textColorPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Currently ${weather.condition.toLowerCase()} in ${weather.cityName}. Expect ${weather.forecastList.isNotEmpty ? weather.forecastList[0].condition.toLowerCase() : "variable"} conditions today.',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textColorSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
