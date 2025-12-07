import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nortus/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:nortus/src/presentation/blocs/auth/auth_event.dart';
import 'package:nortus/src/presentation/pages/auth/widgets/build_login_text_field.dart';
import 'package:nortus/src/presentation/themes/app_colors.dart';
import 'package:nortus/src/presentation/validators/email_validator.dart';
import 'package:nortus/src/presentation/validators/password_validator.dart';

class BuildSignUpForm extends StatefulWidget {
  final double horizontalPadding;

  const BuildSignUpForm({
    required this.horizontalPadding,
    super.key,
  });

  @override
  State<BuildSignUpForm> createState() => _BuildSignUpFormState();
}

class _BuildSignUpFormState extends State<BuildSignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordRepeatController = TextEditingController();
  bool obscureRepeatPassword = true;
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.horizontalPadding,
      ),
      child: Container(
        width: double.infinity,
        height: size.height * 0.38,
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
                  validator: (value) => EmailValidator.signUpValidate(email: value),
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
                  validator: (value) => PasswordValidator.signUpValidate(
                    password: value,
                  ),
                ),
                SizedBox(height: 16),
                BuildLoginTextField(
                  controller: _passwordRepeatController,
                  label: 'Confirme a senha',
                  obscureText: obscureRepeatPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureRepeatPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureRepeatPassword = !obscureRepeatPassword;
                      });
                    },
                  ),
                  validator: (value) => PasswordValidator.signUpRepeatValidate(
                    repeatPassword: value,
                    password: _passwordController.text,
                  ),
                ),
                
                SizedBox(height: 20),
            
                // Confirm button
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.06,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(CreateAccountEvent(
                          login: _emailController.text,
                          password: _passwordController.text,
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
                      'Cadastre-se',
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
}