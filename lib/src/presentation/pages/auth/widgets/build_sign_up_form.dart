import 'package:flutter/material.dart';
import 'package:nortus/src/presentation/pages/auth/widgets/build_login_text_field.dart';
import 'package:nortus/src/presentation/themes/app_colors.dart';

class BuildSignUpForm extends StatelessWidget {
  final double horizontalPadding;

  const BuildSignUpForm({
    required this.horizontalPadding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // TextField
            BuildLoginTextField(
              label: 'Digite seu E-mail',
              hintText: 'exemplo@gmail.com',
              obscureText: false,
            ),
            BuildLoginTextField(
              label: 'Senha',
              hintText: '',
              obscureText: false,
            ),
    
            SizedBox(height: 20),

            // Confirm button
            SizedBox(
              width: double.infinity,
              height: size.height * 0.06,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'Entrar',
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}