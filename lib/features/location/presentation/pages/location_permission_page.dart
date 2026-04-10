import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:globalweather/core/theme/colors.dart';
import 'package:globalweather/features/location/presentation/bloc/location_bloc.dart';
import 'package:globalweather/features/location/presentation/bloc/location_event.dart';

class LocationPermissionPage extends StatelessWidget {
  const LocationPermissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              Container(
                width: 120.w,
                height: 120.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [
                    AppColors.primaryColor.withOpacity(0.3),
                    AppColors.primaryColor.withOpacity(0.05),
                  ]),
                ),
                child: Icon(
                  Icons.location_on_rounded,
                  size: 64.sp,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 40.h),

              // Title
              Text(
                'Enable Location',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textColorPrimary,
                  letterSpacing: -1,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),

              // Subtitle
              Text(
                'GlobalWeather needs your location to show accurate local forecasts and send timely weather alerts.',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: AppColors.textColorSecondary,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 56.h),

              // Allow button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final permission = await Geolocator.requestPermission();
                    if (!context.mounted) return;

                    if (permission == LocationPermission.always ||
                        permission == LocationPermission.whileInUse) {
                      // Permission granted, now check if service is enabled
                      final isServiceEnabled =
                          await Geolocator.isLocationServiceEnabled();
                      if (!isServiceEnabled) {
                        // Prompt to enable service
                        await Geolocator.openLocationSettings();
                        // We don't dispatch yet because we need the user to turn it on
                        // They'll likely come back and click again or we can re-check later
                        return;
                      }

                      context
                          .read<LocationBloc>()
                          .add(LocationPermissionGranted());
                    } else {
                      context
                          .read<LocationBloc>()
                          .add(LocationPermissionDenied());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 18.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  child: Text(
                    'Allow Location Access',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Deny note
              Text(
                'Location access is required for first-time setup.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textColorSecondary.withOpacity(0.5),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
