import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color iconColor;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.iconColor = Colors.blueAccent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withOpacity(0.2),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(icon, color: iconColor, size: 24.sp),
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Colors.white54,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}