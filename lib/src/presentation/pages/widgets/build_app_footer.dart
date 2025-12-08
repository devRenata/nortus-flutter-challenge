import 'package:flutter/material.dart';
import 'package:nortus/src/presentation/themes/app_colors.dart';

class BuildAppFooter extends StatelessWidget {
  const BuildAppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.backgroundBlack,
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: size.height * 0.09,
        top: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nortus',
            style: TextStyle(
              color: AppColors.secondary,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Copyright 2025 Nortus - Todos os Direitos Reservados',
            style: TextStyle(
              color: AppColors.textGray,
              fontSize: 10,
            ),
          )
        ],
      ),
    );
  }
}