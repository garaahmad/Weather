import 'package:flutter/material.dart';
import 'package:globalweather/core/theming/colors.dart';

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
              Expanded(
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
                    const Text(
                      'Next 10 Days',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -2.0,
                        height: 1.0,
                        color: AppColors.textColorPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Variable conditions expected with a transition to cooler temperatures by the weekend.',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textColorSecondary,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.wb_sunny,
                      color: AppColors.secondaryColor,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: '24°',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColorPrimary,
                            ),
                          ),
                          TextSpan(
                            text: ' / 18°',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textColorSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),

          // Forecast List
          _ForecastRow(
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
          _ForecastRow(
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
          _ForecastRow(
            day: 'Mon',
            date: 'AUG 26',
            rain: '40%',
            condition: 'Scattered Showers',
            icon: Icons.cloud_outlined,
            iconColor: AppColors.textColorSecondary,
            low: 17,
            high: 23,
          ),

          const SizedBox(height: 48),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(24),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuAKwtEtOY2fSqw175_Wn8Ok4rE2eHOWBF5IXLI0V8DRMnh8jqN8YoCRKTo5zji4egoKiGKw_OZwwkMStAPYlJYS5NgHRrSVY831opw1B584qv9J62GZEBTok_SioSKivnSLerrX0zVx5fvBbn2YJh5HTzIk--YmB4BeR1fjmFH0OAgccRHn3fvgflkOw8_B4YAerdhh1cQAe-xLrxFHW9pw6wJ49wXOlNspaT7o6QsGzJBfkP814MHpW2xBErR4f62hWAH2xRpE7vA',
                      ),
                      fit: BoxFit.cover,
                      opacity: 0.3,
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'RAINFALL VIEW',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Text(
                          'Precipitation Map',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColorPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  height: 180,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.cardColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.cyclone,
                        color: AppColors.secondaryColor,
                        size: 32,
                      ),
                      const Spacer(),
                      const Text(
                        'PRESSURE ALERT',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColorSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Stable Conditions',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColorPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class _ForecastRow extends StatelessWidget {
  final String day;
  final String date;
  final String rain;
  final String condition;
  final IconData icon;
  final Color iconColor;
  final int low;
  final int high;
  final bool isToday;

  const _ForecastRow({
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
