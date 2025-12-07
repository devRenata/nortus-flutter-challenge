import 'package:flutter/material.dart';
import 'package:nortus/src/presentation/themes/app_colors.dart';

class BuildForgotPassword extends StatelessWidget {
  final double horizontalPadding;

  const BuildForgotPassword({
    super.key,
    required this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(
        horizontal: horizontalPadding,
        vertical: size.height * 0.016,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Esqueci a senha',
            style: TextStyle(
              color: AppColors.white,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.white,
            ),
          ),
          Text(
            '•',
            style: TextStyle(
              fontSize: 30,
              color: AppColors.white,
            ),
          ),
          Text(
            'Continuar sem conta',
            style: TextStyle(
              color: AppColors.white,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}