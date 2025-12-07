import 'package:flutter/material.dart';
import 'package:nortus/src/presentation/themes/app_colors.dart';

class BuildLoginOptionButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSelected;
  final String label;

  const BuildLoginOptionButton({
    required this.isSelected,
    required this.label,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.secondary
                : AppColors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? AppColors.white
                    : AppColors.textBlack,
                fontWeight: isSelected
                    ? FontWeight.bold
                    : FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}