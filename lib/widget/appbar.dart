import 'package:flutter/material.dart';

// Misal ini adalah class ColorAnimated
class ColorAnimated {
  final Color background;
  final Color color;

  ColorAnimated({required this.background, required this.color});
}

// Custom AppBar sebagai StatelessWidget
class WidgetAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ColorAnimated colorAnimated;
  final String title;
  IconButton? icon;

  WidgetAppBar({
    super.key,
    required this.colorAnimated,
    required this.title,
    this.icon,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: colorAnimated.background,
      leading: icon,
      title: Text(
        title,
        style: TextStyle(
          color: colorAnimated.color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
