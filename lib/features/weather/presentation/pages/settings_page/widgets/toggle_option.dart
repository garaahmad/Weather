  import 'package:flutter/material.dart';
import 'package:globalweather/core/theme/colors.dart';

Widget buildToggleOption(String text, {bool active = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: active ? AppColors.primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: active ? Colors.white : AppColors.textColorSecondary,
        ),
      ),
    );
  }