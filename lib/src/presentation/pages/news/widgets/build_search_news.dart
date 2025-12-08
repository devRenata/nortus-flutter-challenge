import 'package:flutter/material.dart';
import 'package:nortus/src/presentation/themes/app_colors.dart';

class BuildSearchNews extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const BuildSearchNews({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: AppColors.secondary,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Pesquisar',
        hintStyle: TextStyle(color: AppColors.textGray),
        errorStyle: const TextStyle(color: AppColors.error),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderGray),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: AppColors.secondary),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: AppColors.error),
        ),
      ),
    );
  }
}