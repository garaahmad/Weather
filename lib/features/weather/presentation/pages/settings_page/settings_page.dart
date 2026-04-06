import 'package:flutter/material.dart';
import 'package:globalweather/core/theme/colors.dart';
import 'package:globalweather/features/weather/presentation/pages/settings_page/widgets/category_header.dart';
import 'package:globalweather/features/weather/presentation/pages/settings_page/widgets/settings_card.dart';
import 'package:globalweather/features/weather/presentation/pages/settings_page/widgets/settings_row.dart';
import 'package:globalweather/features/weather/presentation/pages/settings_page/widgets/toggle_option.dart';


class WeatherSettingsPage extends StatelessWidget {
  const WeatherSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w900,
              letterSpacing: -2.0,
              color: AppColors.textColorPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Customize your meteorological experience',
            style: TextStyle(fontSize: 16, color: AppColors.textColorSecondary),
          ),
          const SizedBox(height: 48),
          buildCategoryHeader('UNITS'),
          buildSettingsCard(
            icon: Icons.thermostat,
            title: 'Temperature Scale',
            subtitle: 'Choose your preferred unit',
            trailing: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.surfaceColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  buildToggleOption('Celsius', active: true),
                  buildToggleOption('Fahrenheit'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          buildCategoryHeader('NOTIFICATIONS'),
          buildSettingsCard(
            icon: Icons.notifications_active,
            title: 'Severe Weather Alerts',
            subtitle: 'Instant updates on critical changes',
            iconColor: AppColors.secondaryColor,
            trailing: Switch(
              value: true,
              onChanged: (v) {},
              activeColor: AppColors.primaryColor,
              activeTrackColor: AppColors.primaryColor.withOpacity(0.3),
            ),
          ),
          const SizedBox(height: 32),
          buildCategoryHeader('APPEARANCE'),
          buildSettingsCard(
            icon: Icons.dark_mode,
            title: 'Theme',
            subtitle: 'Currently Dark Mode',
            iconColor: AppColors.tertiaryColor,
            trailing: const Icon(
              Icons.chevron_right,
              color: AppColors.textColorSecondary,
            ),
          ),
          const SizedBox(height: 32),
          buildCategoryHeader('ABOUT'),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant.withOpacity(0.3),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Column(
              children: [
                buildSettingsRow(
                  icon: Icons.info_outline,
                  title: 'App Version',
                  value: 'v2.4.0 (Stable Build)',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    color: Colors.white.withOpacity(0.05),
                    height: 1,
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
          const SizedBox(height: 64),
          const Center(
            child: Opacity(
              opacity: 0.2,
              child: Column(
                children: [
                  Icon(Icons.cloud_done, size: 48),
                  SizedBox(height: 8),
                  Text(
                    'GLOBALWEATHER',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 120),
        ],
      ),
    );
  }



  

 


}
