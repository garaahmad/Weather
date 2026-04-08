import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:globalweather/core/theme/colors.dart';
import 'package:globalweather/features/weather/presentation/cubit/weather_cubit.dart';

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key});

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
      child: SearchAnchor(
        viewBackgroundColor: AppColors.surfaceColor,
        viewShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            controller: controller,
            elevation: WidgetStateProperty.all(0),
            backgroundColor: WidgetStateProperty.all(AppColors.surfaceColor),
            padding: WidgetStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0.w),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
                side: BorderSide(
                  color: Colors.white.withValues(alpha: 0.05),
                  width: 1.w,
                ),
              ),
            ),
            
            hintText: 'Search city/country...',
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                context.read<WeatherCubit>().fetchWeather(value);
              }
            },
            onTap: () {
              controller.openView();
            },
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          return List<ListTile>.generate(1, (int index) {
            final String item = controller.text;
            if (item.isEmpty) return const ListTile(title: Text("Type to search..."));
            return ListTile(
              title: Text(
                'Search for "$item"',
                style: TextStyle(color: AppColors.textColorPrimary, fontSize: 16.sp),
              ),
              leading: Icon(Icons.location_city, color: AppColors.primaryColor, size: 24.sp),
              onTap: () {
                context.read<WeatherCubit>().fetchWeather(item);
                controller.closeView(item);
              },
            );
          });
        },
      ),
    );
  }
}
