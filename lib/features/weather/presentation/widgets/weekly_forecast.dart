import 'package:flutter/material.dart';
import 'package:globalweather/core/theming/colors.dart';

class WeeklyForecast extends StatelessWidget {
  const WeeklyForecast({super.key});

  @override
  Widget build(BuildContext context) {
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
            '7-DAY FORECAST',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: AppColors.textColorSecondary,
            ),
          ),
          const SizedBox(height: 24),
          _ForecastRow(
            day: 'Today',
            icon: Icons.wb_sunny,
            iconColor: AppColors.secondaryColor,
            low: '18°',
            high: '24°',
            gradientStops: const [0.2, 0.8],
          ),
          const Divider(height: 32, color: Colors.white10),
          _ForecastRow(
            day: 'Mon',
            icon: Icons.cloud_outlined,
            iconColor: AppColors.textColorSecondary,
            low: '16°',
            high: '21°',
            gradientStops: const [0.1, 0.6],
          ),
          const Divider(height: 32, color: Colors.white10),
          _ForecastRow(
            day: 'Tue',
            icon: Icons.beach_access_outlined, // Rain icon substitute
            iconColor: AppColors.primaryColor,
            low: '14°',
            high: '17°',
            gradientStops: const [0.0, 0.4],
          ),
        ],
      ),
    );
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
