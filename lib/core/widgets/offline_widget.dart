import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:globalweather/core/theme/colors.dart';

/// A friendly, non-intrusive widget shown when there's no internet.
/// No scary error messages — just a calm icon, a short note, and
/// an optional retry button.
class OfflineWidget extends StatelessWidget {
  final VoidCallback? onRetry;
  final bool compact;

  const OfflineWidget({
    super.key,
    this.onRetry,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    if (compact) return _buildBanner();
    return _buildFullPage();
  }

  /// Full-page version shown when there is no cached data at all.
  Widget _buildFullPage() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_off_rounded,
              size: 72.sp,
              color: Colors.white38,
            ),
            SizedBox(height: 24.h),
            Text(
              'No Internet Connection',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Weather data will refresh automatically\nwhen you reconnect.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white38,
                height: 1.5,
              ),
            ),
            if (onRetry != null) ...[
              SizedBox(height: 32.h),
              TextButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded, color: AppColors.primaryColor),
                label: Text(
                  'Try Again',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Compact banner shown at the top of the page when we still
  /// have cached/stale data to display underneath.
  Widget _buildBanner() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.cloud_off_rounded, size: 20.sp, color: Colors.orange),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'You\'re offline — showing last updated data',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.orange,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
