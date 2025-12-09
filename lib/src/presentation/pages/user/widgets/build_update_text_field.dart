import 'package:flutter/material.dart';
import 'package:nortus/src/presentation/themes/app_colors.dart';

class BuildUpdateTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;

  const BuildUpdateTextField({
    super.key,
    this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: AppColors.secondary,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.textGray),
        errorStyle: const TextStyle(color: AppColors.error),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.secondary),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.secondary),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}