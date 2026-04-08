import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TemperatureScaleToggle extends StatefulWidget {
  final Function(bool isCelsius) onToggle;
  final bool initialValue;

  const TemperatureScaleToggle({
    super.key,
    required this.onToggle,
    this.initialValue = true,
  });

  @override
  State<TemperatureScaleToggle> createState() => _TemperatureScaleToggleState();
}

class _TemperatureScaleToggleState extends State<TemperatureScaleToggle> {
  late bool isCelsius;

  @override
  void initState() {
    super.initState();
    isCelsius = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isCelsius = !isCelsius;
        });
        widget.onToggle(isCelsius);
      },
      child: Container(
        width: 100.w,
        height: 36.h,
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A), // Very dark blue/slate
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1.w,
          ),
        ),
        child: Stack(
          children: [
            // Sliding Background Indicator
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOutBack,
              alignment: isCelsius ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                width: 48.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF38BDF8), // Cyan/Light Blue
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF38BDF8).withValues(alpha: 0.3),
                      blurRadius: 8.r,
                      offset: Offset(0, 2.h),
                    ),
                  ],
                ),
              ),
            ),
            // Text Overlays
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      '°C',
                      style: TextStyle(
                        fontFamily: 'Outfit', // A modern font, or fallback to default
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        color: isCelsius ? const Color(0xFF0F172A) : Colors.white70,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      '°F',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        color: !isCelsius ? const Color(0xFF0F172A) : Colors.white70,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
