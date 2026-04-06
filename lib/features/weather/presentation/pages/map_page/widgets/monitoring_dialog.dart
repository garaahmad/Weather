import 'package:flutter/material.dart';
import 'package:globalweather/core/theme/colors.dart';
import 'package:latlong2/latlong.dart';

void showMonitoringDialog(BuildContext context, LatLng point) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          "Site Monitoring",
          style: TextStyle(color: AppColors.textColorPrimary),
        ),
        content: const Text(
          "Do you want this site to be constantly monitored?",
          style: TextStyle(color: AppColors.textColorSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "No",
              style: TextStyle(color: AppColors.textColorSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Add monitoring logic here
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Site added to monitoring list")),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("Yes", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }