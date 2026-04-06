import 'package:flutter/material.dart';
import 'package:globalweather/core/theme/colors.dart';
import 'package:globalweather/features/weather/presentation/pages/forecast_page/detailed_outlook.dart';
import 'package:globalweather/features/weather/presentation/pages/forecast_page/forecast_row.dart';
import 'package:globalweather/features/weather/presentation/widgets/state_card.dart';

class ForecastPage extends StatelessWidget {
  const ForecastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Section
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DetailedOutlook(),
              const SizedBox(width: 16),
              WeatherStateCard(
                icon: Icons.wb_sunny,
                title: '24°',
                value: '/ 18°',
                color: AppColors.secondaryColor,
              ),
            ],
          ),
          const SizedBox(height: 48),
          ForecastRow(
            day: 'Today',
            date: 'AUG 24',
            rain: '12%',
            condition: 'Mostly Sunny',
            icon: Icons.wb_sunny,
            iconColor: AppColors.secondaryColor,
            low: 18,
            high: 24,
            isToday: true,
          ),
          const SizedBox(height: 16),
          ForecastRow(
            day: 'Sun',
            date: 'AUG 25',
            rain: '85%',
            condition: 'Heavy Rain',
            icon: Icons.beach_access,
            iconColor: AppColors.primaryColor,
            low: 15,
            high: 21,
          ),
          const SizedBox(height: 16),
          ForecastRow(
            day: 'Mon',
            date: 'AUG 26',
            rain: '40%',
            condition: 'Scattered Showers',
            icon: Icons.cloud_outlined,
            iconColor: AppColors.textColorSecondary,
            low: 17,
            high: 23,
          ),
          const SizedBox(height: 16),
          ForecastRow(
            day: 'Tue',
            date: 'AUG 27',
            rain: '20%',
            condition: 'Sunny',
            icon: Icons.wb_sunny,
            iconColor: AppColors.secondaryColor,
            low: 17,
            high: 23,
          ),
          const SizedBox(height: 16),
          ForecastRow(
            day: 'Wed',
            date: 'AUG 28',
            rain: '10%',
            condition: 'Sunny',
            icon: Icons.wb_sunny,
            iconColor: AppColors.secondaryColor,
            low: 17,
            high: 23,
          ),
          const SizedBox(height: 16),
          ForecastRow(
            day: 'Thu',
            date: 'AUG 29',
            rain: '10%',
            condition: 'Scattered Showers',
            icon: Icons.cloud_outlined,
            iconColor: AppColors.textColorSecondary,
            low: 17,
            high: 23,
          ),
          const SizedBox(height: 16),
          ForecastRow(
            day: 'Fri',
            date: 'AUG 30',
            rain: '10%',
            condition: 'Sunny',
            icon: Icons.wb_sunny,
            iconColor: AppColors.secondaryColor,
            low: 17,
            high: 23,
          ),
          const SizedBox(height: 16),
          ForecastRow(
            day: 'Sat',
            date: 'AUG 31',
            rain: '10%',
            condition: 'Scattered Showers',
            icon: Icons.cloud_outlined,
            iconColor: AppColors.textColorSecondary,
            low: 17,
            high: 23,
          ),
        ],
      ),
    );
  }
}
