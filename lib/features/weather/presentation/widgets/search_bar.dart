import 'package:flutter/material.dart';
import 'package:globalweather/core/theming/colors.dart';

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key});

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SearchAnchor(
        // The modal overlay view styling
        viewBackgroundColor: AppColors.surfaceColor,
        viewShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            controller: controller,
            elevation: WidgetStateProperty.all(0),
            backgroundColor: WidgetStateProperty.all(AppColors.surfaceColor),
            padding: const WidgetStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: Colors.white.withOpacity(0.05),
                  width: 1,
                ),
              ),
            ),
            leading: const Icon(
              Icons.search,
              color: AppColors.textColorSecondary,
              size: 20,
            ),
            hintText: 'Search city/country...',
            hintStyle: WidgetStateProperty.all(
              const TextStyle(
                color: AppColors.placeholderColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            textStyle: WidgetStateProperty.all(
              const TextStyle(color: AppColors.textColorPrimary, fontSize: 14),
            ),
            onTap: () {
              controller.openView();
            },
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
              return List<ListTile>.generate(5, (int index) {
                final String item = 'Sample Location $index';
                return ListTile(
                  title: Text(
                    item,
                    style: const TextStyle(color: AppColors.textColorPrimary),
                  ),
                  onTap: () {
                    setState(() {
                      controller.closeView(item);
                    });
                  },
                );
              });
            },
      ),
    );
  }
}
