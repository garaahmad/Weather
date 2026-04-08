import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:globalweather/core/theme/colors.dart';
import 'package:globalweather/features/weather/data/repositories/settings_repository.dart';
import 'package:globalweather/features/weather/presentation/cubit/settings_cubit.dart';
import 'package:globalweather/features/weather/presentation/pages/settings_page/widgets/category_header.dart';
import 'package:globalweather/features/weather/presentation/pages/settings_page/widgets/settings_card.dart';
import 'package:globalweather/features/weather/presentation/pages/settings_page/widgets/settings_row.dart';
import 'package:globalweather/features/weather/presentation/pages/settings_page/widgets/toggle_option.dart';

class WeatherSettingsPage extends StatelessWidget {
  const WeatherSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Settings',
            style: TextStyle(
              fontSize: 48.sp,
              fontWeight: FontWeight.w900,
              letterSpacing: -2.0,
              color: AppColors.textColorPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Customize your meteorological experience',
            style: TextStyle(fontSize: 16.sp, color: AppColors.textColorSecondary),
          ),
          SizedBox(height: 48.h),
          buildCategoryHeader('UNITS'),
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return buildSettingsCard(
                icon: Icons.thermostat,
                title: 'Temperature Scale',
                subtitle: 'Choose your preferred unit',
                trailing: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  
                  child: Row(
                    children: [
                      buildToggleOption(
                        'Celsius',
                        active: state.unit == TemperatureUnit.celsius,
                        onTap: () => context
                            .read<SettingsCubit>()
                            .setTemperatureUnit(TemperatureUnit.celsius),
                      ),
                      buildToggleOption(
                        'Fahrenheit',
                        active: state.unit == TemperatureUnit.fahrenheit,
                        onTap: () => context
                            .read<SettingsCubit>()
                            .setTemperatureUnit(TemperatureUnit.fahrenheit),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 32.h),
          buildCategoryHeader('NOTIFICATIONS'),
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return buildSettingsCard(
                icon: Icons.notifications_active,
                title: 'Periodic Weather Updates',
                subtitle: 'Get notified with weather status every 5 hours',
                iconColor: AppColors.secondaryColor,
                trailing: Switch(
                  value: state.notificationsEnabled,
                  onChanged: (v) {
                    context.read<SettingsCubit>().toggleNotifications(v);
                  },
                  activeColor: AppColors.primaryColor,
                  activeTrackColor: AppColors.primaryColor.withOpacity(0.3),
                ),
              );
            },
          ),
          SizedBox(height: 32.h),
          buildCategoryHeader('ABOUT'),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant.withOpacity(0.3),
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Column(
              children: [
                buildSettingsRow(
                  icon: Icons.info_outline,
                  title: 'App Version',
                  value: 'v1.0.0 (Stable Build)',
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Divider(
                    color: Colors.white.withOpacity(0.05),
                    height: 1.h,
                  ),
                ),
                buildSettingsRow(
                  icon: Icons.policy_outlined,
                  title: 'Privacy Policy',
                  showArrow: true,
                ),
              ],
            ),
          ),
          SizedBox(height: 64.h),
          Center(
            child: Opacity(
              opacity: 0.2,
              child: Column(
                children: [
                  Icon(Icons.cloud_done, size: 48.sp),
                  SizedBox(height: 8.h),
                  Text(
                    'GLOBALWEATHER',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 120.h),
        ],
      ),
    );
  }
}
