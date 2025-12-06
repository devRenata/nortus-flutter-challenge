import 'package:flutter/material.dart';
import 'package:nortus/src/presentation/themes/app_colors.dart';
import 'package:nortus/src/presentation/themes/app_fonts.dart';

class AppTheme {
  static ThemeData get appTheme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.white,
      primaryColor: AppColors.primary,
      fontFamily: AppFonts.poppins,
    );
  }
}