  import 'package:flutter/cupertino.dart';
import 'package:globalweather/core/theme/colors.dart';

Widget buildCategoryHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: AppColors.textColorSecondary,
        ),
      ),
    );
  }