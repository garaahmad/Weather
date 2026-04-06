import 'package:flutter/material.dart';
import 'package:globalweather/core/theme/colors.dart';

class ForecastRow extends StatelessWidget {
  final String day;
  final String date;
  final String rain;
  final String condition;
  final IconData icon;
  final Color iconColor;
  final int low;
  final int high;
  final bool isToday;

  const ForecastRow({
    required this.day,
    required this.date,
    required this.rain,
    required this.condition,
    required this.icon,
    required this.iconColor,
    required this.low,
    required this.high,
    this.isToday = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isToday
            ? AppColors.surfaceColor.withOpacity(0.6)
            : AppColors.surfaceColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isToday
              ? AppColors.primaryColor.withOpacity(0.2)
              : Colors.white.withOpacity(0.05),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  day,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColorPrimary,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColorSecondary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                const Icon(
                  Icons.water_drop,
                  color: AppColors.primaryColor,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  rain,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Icon(icon, color: iconColor, size: 28)),
          Expanded(
            flex: 3,
            child: Container(
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(2),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: 0.6,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.primaryColor,
                        AppColors.secondaryColor,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$high°',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColorPrimary,
                ),
              ),
              Text(
                '$low°',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textColorSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}