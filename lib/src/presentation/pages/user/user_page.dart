import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nortus/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:nortus/src/presentation/blocs/auth/auth_event.dart';
import 'package:nortus/src/presentation/blocs/news/news_bloc.dart';
import 'package:nortus/src/presentation/blocs/news/news_state.dart';
import 'package:nortus/src/presentation/blocs/user/user_bloc.dart';
import 'package:nortus/src/presentation/blocs/user/user_event.dart';
import 'package:nortus/src/presentation/blocs/user/user_state.dart';
import 'package:nortus/src/presentation/pages/user/widgets/build_favorite_news_card.dart';
import 'package:nortus/src/presentation/pages/user/widgets/build_user_action_button.dart';
import 'package:nortus/src/presentation/pages/widgets/build_app_bar.dart';
import 'package:nortus/src/presentation/routes/app_routes.dart';
import 'package:nortus/src/presentation/themes/app_colors.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void initState() {
    super.initState();

    final user = context.read<UserBloc>().state.user;
    if (user == null) {
      context.read<UserBloc>().add(LoadUserEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state.status == UserStatus.loading ||
              state.status == UserStatus.initial) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }

          if (state.status == UserStatus.success) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: SingleChildScrollView(
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLogoName(),
                      _buildUserInfo(state),
                      _buildFavoriteNews(),
                    ],
                  ),
                ),
              ),
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildUserInfo(UserState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        Text(
          state.user!.name,
          style: TextStyle(
            color: AppColors.textBlack,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 5),
        Text(
          state.user!.email,
          style: TextStyle(
            color: AppColors.textBlack,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              color: AppColors.textBlack,
            ),
            SizedBox(width: 8),
            Text(
              '${state.user!.address.city}, ${state.user!.address.country}',
              style: TextStyle(
                color: AppColors.textBlack,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        BuildUserActionButton(
          onPressed: () {

          },
          icon: Icons.settings_outlined,
          color: AppColors.textBlack,
          text: 'Configurações de usuário',
        ),
        SizedBox(height: 20),
        BuildUserActionButton(
          onPressed: () {
            context.read<AuthBloc>().add(LogoutEvent());
            context.go(AppRoutes.login);
          },
          color: AppColors.error,
          text: 'Sair da conta',
        ),
      ],
    );
  }

  Widget _buildFavoriteNews() {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.secondary,
                    width: 3,
                  ),
                ),
              ),
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                'Notícias favoritadas',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 40),

            if (state.favoriteNews.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: state.favoriteNews.length,
                itemBuilder: (context, index) {
                  final news = state.favoriteNews[index];
                  return BuildFavoriteNewsCard(news: news);
                },
              )
            else
              Text(
                'Nenhuma notícia favoritada.',
                style: TextStyle(
                  color: AppColors.textGray,
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildLogoName() {
    return Container(
      width: double.infinity,
      color: AppColors.backgroundGray,
      padding: EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Text(
        'Nortus',
        style: TextStyle(
          color: AppColors.textBlack,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}