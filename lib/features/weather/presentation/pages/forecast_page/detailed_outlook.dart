import 'package:flutter/material.dart';
import 'package:globalweather/core/theme/colors.dart';

class DetailedOutlook extends StatelessWidget {
  const DetailedOutlook({super.key});

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
    );
  }
}
