import 'package:go_router/go_router.dart';
import 'package:nortus/src/presentation/pages/auth/login_page.dart';
import 'package:nortus/src/presentation/pages/initial/splash_page.dart';
import 'package:nortus/src/presentation/pages/news/news_details_page.dart';
import 'package:nortus/src/presentation/pages/news/news_page.dart';
import 'package:nortus/src/presentation/pages/user/update_user_page.dart';
import 'package:nortus/src/presentation/pages/user/user_page.dart';
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
    GoRoute(
      path: AppRoutes.user,
      name: 'user',
      builder: (context, state) => const UserPage(),
    ),
    GoRoute(
      path: AppRoutes.updateUser,
      name: 'updateUser',
      builder: (context, state) => const UpdateUserPage(),
    ),
    GoRoute(
      path: '${AppRoutes.newsDetails}/:id',
      name: 'newsDetails',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return NewsDetailsPage(id: id);
      }
    ),
  ],
);