import 'package:flutter/material.dart';
import 'package:nortus/src/presentation/themes/app_colors.dart';

class BuildUserActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final String text;
  final IconData? icon;

  const BuildUserActionButton({
    required this.onPressed,
    required this.text,
    required this.color,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.06,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.white,
          foregroundColor: color,
          shadowColor: Colors.transparent,
          side: BorderSide(
            color: color,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: color,
              ),
            SizedBox(width: 8),
            Text(text),
          ],
        ),
      ),
    );
  }
}