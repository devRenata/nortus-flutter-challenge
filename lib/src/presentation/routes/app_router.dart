import 'package:go_router/go_router.dart';
import 'package:nortus/src/presentation/pages/auth/login_page.dart';
import 'package:nortus/src/presentation/pages/initial/splash_page.dart';
import 'package:nortus/src/presentation/pages/news/news_page.dart';
import 'package:nortus/src/presentation/routes/app_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: AppRoutes.news,
      name: 'news',
      builder: (context, state) => const NewsPage(),
    ),
  ],
);