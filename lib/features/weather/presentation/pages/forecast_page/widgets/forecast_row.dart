import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: isToday
            ? AppColors.surfaceColor.withValues(alpha: 0.6)
            : AppColors.surfaceColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: isToday
              ? AppColors.primaryColor.withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.05),
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
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColorPrimary,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 11.sp,
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
                Icon(
                  Icons.water_drop,
                  color: AppColors.primaryColor,
                  size: 14.sp,
                ),
                SizedBox(width: 4.w),
                Text(
                  rain,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Icon(icon, color: iconColor, size: 28.sp)),
          Expanded(
            flex: 3,
            child: Container(
              height: 4.h,
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(2.r),
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
                    borderRadius: BorderRadius.circular(2.r),
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
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColorPrimary,
                ),
              ),
              Text(
                '$low°',
                style: TextStyle(
                  fontSize: 14.sp,
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