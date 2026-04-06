import 'package:flutter/material.dart';
import 'package:globalweather/core/theme/colors.dart';

class WeatherSettingsPage extends StatelessWidget {
  const WeatherSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
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

          // Units
          _buildCategoryHeader('UNITS'),
          _buildSettingsCard(
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
                  _buildToggleOption('Celsius', active: true),
                  _buildToggleOption('Fahrenheit'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Notifications
          _buildCategoryHeader('NOTIFICATIONS'),
          _buildSettingsCard(
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

          // Appearance
          _buildCategoryHeader('APPEARANCE'),
          _buildSettingsCard(
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

          // About
          _buildCategoryHeader('ABOUT'),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant.withOpacity(0.3),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Column(
              children: [
                _buildSettingsRow(
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
                _buildSettingsRow(
                  icon: Icons.policy_outlined,
                  title: 'Privacy Policy',
                  showArrow: true,
                ),
              ],
            ),
          ),

          // Footer
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

  Widget _buildCategoryHeader(String title) {
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

  Widget _buildSettingsCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
    Color iconColor = AppColors.primaryColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textColorSecondary,
                  ),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }

  Widget _buildSettingsRow({
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

  Widget _buildToggleOption(String text, {bool active = false}) {
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
}
