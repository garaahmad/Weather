import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:globalweather/core/theme/colors.dart';

Widget buildMapFab(
    IconData icon, {
    bool isPrimary = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: isPrimary
              ? AppColors.primaryColor
              : AppColors.surfaceColor.withOpacity(0.9),
          shape: isPrimary ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isPrimary ? null : BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: isPrimary ? Colors.white : AppColors.textColorPrimary,
        ),
      ),
    );
  }