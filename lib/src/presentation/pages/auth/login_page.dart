import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nortus/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:nortus/src/presentation/blocs/auth/auth_state.dart';
import 'package:nortus/src/presentation/pages/auth/widgets/build_forgot_password.dart';
import 'package:nortus/src/presentation/pages/auth/widgets/build_sign_in_form.dart';
import 'package:nortus/src/presentation/pages/auth/widgets/build_login_option_button.dart';
import 'package:nortus/src/presentation/pages/auth/widgets/build_sign_up_form.dart';
import 'package:nortus/src/presentation/pages/widgets/alert_widget.dart';
import 'package:nortus/src/presentation/routes/app_routes.dart';
import 'package:nortus/src/presentation/themes/app_assets.dart';
import 'package:nortus/src/presentation/themes/app_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isSignIn = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.success) {
          context.go(AppRoutes.news);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth > 600;
      
            return BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                final isLoading = state.status == AuthStatus.loading;
                final isError = state.status == AuthStatus.failure;

                return SafeArea(
                  child: Stack(
                    children: [
                      _buildBackground(size, isTablet),

                      if (isLoading)
                        Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),

                      if (!isLoading)
                        _buildLoginPanel(size),

                      if (isError)
                        AlertWidget(
                          message: state.message ?? 'Ocorreu um erro, tente novamente.',
                          type: ContentType.error,
                        ),
                    ],
                  ),
                );
              }
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoginPanel(Size size) {
    double loginOptionsHeight = size.height * 0.074;
    final horizontalPadding = size.width * 0.05;

    double formHeight = isSignIn
        ? size.height * 0.48
        : size.height * 0.56;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Login form
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: formHeight,
            padding: EdgeInsets.only(
              top: loginOptionsHeight / 2 + size.height * 0.02,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                isSignIn
                    ? BuildSignInForm(horizontalPadding: horizontalPadding)
                    : BuildSignUpForm(horizontalPadding: horizontalPadding),
                BuildForgotPassword(horizontalPadding: horizontalPadding),
              ],
            ),
          ),
        ),

        // Login options (signIn and signUp)
        Positioned(
          left: horizontalPadding,
          right: horizontalPadding,
          bottom: formHeight - (loginOptionsHeight / 2),
          child: Container(
            padding: EdgeInsets.all(10),
            height: loginOptionsHeight,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              children: [
                BuildLoginOptionButton(
                  isSelected: isSignIn,
                  label: 'Acessar conta',
                  onTap: () {
                    setState(() => isSignIn = true);
                  },
                ),
                SizedBox(width: 10),
                BuildLoginOptionButton(
                  isSelected: !isSignIn,
                  label: 'Não tenho conta',
                  onTap: () {
                    setState(() => isSignIn = false);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBackground(Size size, bool isTablet) {
    final imageSize = size.width * 1.3;
    final leftPadding = size.width * 0.06;
    final imageTopPadding = size.height * 0.09;
    final textTopPadding = imageTopPadding + size.height * 0.02;

    return Stack(
      children: [
        // Logo image
        Positioned(
          top: imageTopPadding,
          left: leftPadding,
          child: Image.asset(
            width: imageSize,
            AppAssets.images.nortusLogo,
            color: AppColors.logoGray,
          ),
        ),
        // Logo name
        Positioned( 
          left: leftPadding,
          top: textTopPadding,
          child: Text(
            'Nortus',
            style: TextStyle(
              fontSize: isTablet ? 52 : 38,
              fontWeight: FontWeight.bold,
              color: AppColors.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
