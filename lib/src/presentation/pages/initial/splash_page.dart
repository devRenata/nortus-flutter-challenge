import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nortus/src/presentation/notifiers/keep_logged_notifier.dart';
import 'package:nortus/src/presentation/routes/app_routes.dart';
import 'package:nortus/src/presentation/themes/app_colors.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

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

  Future<void> _checkSession() async {
    final notifier = context.read<KeepLoggedNotifier>();

    while (notifier.isLogged == null) {
      await Future.delayed(const Duration(seconds: 3));
    }

    if (!mounted) return;
    if (notifier.isLogged!) {
      context.go(AppRoutes.news);
    } else {
      context.go(AppRoutes.login);
    }
  }
}
