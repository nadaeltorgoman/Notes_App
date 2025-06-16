import 'package:flutter/material.dart';
import 'package:notes/core/utils/app_colors.dart';

class CustomIconButton extends StatelessWidget {
  final Color? color;
  final Function() onTap;
  final IconData icon;
  const CustomIconButton({
    super.key, this.color, required this.onTap, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color ?? AppColors.accentColor,
        ),
        child: Icon(icon, color: AppColors.whiteColor),
      ),
    );
  }
}
