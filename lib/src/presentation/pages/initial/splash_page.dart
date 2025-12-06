import 'package:flutter/material.dart';
import 'package:nortus/src/presentation/themes/app_colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.primary,
        child: Center(
          child: Text(
            'Nortus',
            style: TextStyle(
              fontSize: 56,
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}