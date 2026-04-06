 import 'package:flutter/material.dart';
import 'package:globalweather/core/theme/colors.dart';

Widget buildSettingsRow({
    required IconData icon,
    required String title,
    String? value,
    bool showArrow = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textColorSecondary),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          if (value != null)
            Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textColorSecondary,
              ),
            ),
          if (showArrow)
            const Icon(
              Icons.open_in_new,
              size: 16,
              color: AppColors.textColorSecondary,
            ),
        ],
      ),
    );
  }