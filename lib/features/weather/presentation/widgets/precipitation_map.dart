import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:globalweather/core/theme/colors.dart';

class PrecipitationMap extends StatelessWidget {
  const PrecipitationMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'PRECIPITATION MAP',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: AppColors.textColorSecondary,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.open_in_full,
                  size: 20.sp,
                  color: AppColors.textColorSecondary,
                ),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Container(
            height: 200.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.surfaceColor.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(32.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuAKwtEtOY2fSqw175_Wn8Ok4rE2eHOWBF5IXLI0V8DRMnh8jqN8YoCRKTo5zji4egoKiGKw_OZwwkMStAPYlJYS5NgHRrSVY831opw1B584qv9J62GZEBTok_SioSKivnSLerrX0zVx5fvBbn2YJh5HTzIk--YmB4BeR1fjmFH0OAgccRHn3fvgflkOw8_B4YAerdhh1cQAe-xLrxFHW9pw6wJ49wXOlNspaT7o6QsGzJBfkP814MHpW2xBErR4f62hWAH2xRpE7vA',
                ),
                fit: BoxFit.cover,
                opacity: 0.5,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 16.h,
                  left: 16.w,
                  child: Row(
                    children: [
                      Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'LIVE RADAR',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                          color: AppColors.textColorPrimary,
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
    );
  }
}
