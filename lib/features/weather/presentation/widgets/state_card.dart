import 'package:flutter/material.dart';

class WeatherStateCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String? unit;
  final Color? color;

  const WeatherStateCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.unit,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120, // Adjusted for a card-like feel
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withOpacity(0.2), // Premium dark slate
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(0.05), width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon with a subtle glow
          Icon(
            icon,
            color: color ?? const Color(0xFF38BDF8), // Cyan/Light Blue
            size: 28,
          ),
          const SizedBox(height: 16),
          // Title (Label)
          Text(
            title.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 12),
          // Value and Unit
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              if (unit != null)
                Text(
                  unit!,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
