import 'package:flutter/material.dart';
import 'package:nortus/src/data/di/injector.dart';
import 'package:nortus/src/presentation/routes/app_router.dart';
import 'package:nortus/src/presentation/themes/app_theme.dart';

void main() {
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Nortus',
      theme: AppTheme.appTheme,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
