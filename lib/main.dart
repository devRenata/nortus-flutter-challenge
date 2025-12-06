import 'package:flutter/material.dart';
import 'package:nortus/src/data/di/injector.dart';
import 'package:nortus/src/presentation/notifiers/keep_logged_notifier.dart';
import 'package:nortus/src/presentation/routes/app_router.dart';
import 'package:nortus/src/presentation/themes/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => serviceLocator<KeepLoggedNotifier>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Nortus',
        theme: AppTheme.appTheme,
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
