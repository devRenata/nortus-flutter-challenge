import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nortus/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:nortus/src/presentation/blocs/auth/auth_event.dart';
import 'package:nortus/src/presentation/pages/auth/widgets/build_login_text_field.dart';
import 'package:nortus/src/presentation/themes/app_colors.dart';
import 'package:nortus/src/presentation/validators/email_validator.dart';
import 'package:nortus/src/presentation/validators/password_validator.dart';

class BuildSignInForm extends StatefulWidget {
  final double horizontalPadding;

  const BuildSignInForm({
    required this.horizontalPadding,
    super.key,
  });

  @override
  State<BuildSignInForm> createState() => _BuildSignInFormState();
}

class _BuildSignInFormState extends State<BuildSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  bool keepLogged = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.horizontalPadding,
      ),
      child: Container(
        width: double.infinity,
        height: size.height * 0.335,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 5),
                BuildLoginTextField(
                  controller: _emailController,
                  label: 'Digite seu E-mail',
                  hintText: 'exemplo@gmail.com',
                  validator: (value) => EmailValidator.signInValidate(email: value),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16),
                BuildLoginTextField(
                  controller: _passwordController,
                  label: 'Digite a senha',
                  obscureText: obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                  validator: (value) => PasswordValidator.signInValidate(
                    password: value,
                  ),
                ),
                
                _buildKeepLogged(),
            
                // Confirm button
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.06,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(SubmitLoginEvent(
                          login: _emailController.text,
                          password: _passwordController.text,
                          keepLogged: keepLogged,
                        ));
                      }
                    },
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
        ),
      ),
    );
  }

  Widget _buildKeepLogged() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                keepLogged = !keepLogged;
              });
            },
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: keepLogged
                    ? AppColors.secondary
                    : AppColors.white,
                border: Border.all(
                  width: 2,
                  color: keepLogged
                      ? AppColors.secondary
                      : AppColors.borderGray,
                )
              ),
              child: keepLogged
                  ? const Icon(
                    Icons.check_rounded,
                    size: 14,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  )
                  : null,
            ),
          ),
          SizedBox(width: 10),
          Text('Mantenha-me conectado'),
        ],
      ),
    );
  }
}
