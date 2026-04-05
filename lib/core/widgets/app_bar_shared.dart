import 'package:flutter/material.dart';
import 'package:globalweather/core/theming/colors.dart';

class CustomSharedAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  const CustomSharedAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.appbarTitleColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.blue),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.blue),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
