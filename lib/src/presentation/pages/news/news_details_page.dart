import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nortus/src/presentation/blocs/news/news_bloc.dart';
import 'package:nortus/src/presentation/blocs/news/news_event.dart';
import 'package:nortus/src/presentation/blocs/news/news_state.dart';
import 'package:nortus/src/presentation/pages/news/widgets/build_related_news_card.dart';
import 'package:nortus/src/presentation/pages/widgets/build_app_bar.dart';
import 'package:nortus/src/presentation/pages/widgets/build_app_footer.dart';
import 'package:nortus/src/presentation/routes/app_routes.dart';
import 'package:nortus/src/presentation/themes/app_colors.dart';

class NewsDetailsPage extends StatefulWidget {
  final int id;

  const NewsDetailsPage({
    required this.id,
    super.key,
  });

  @override
  State<NewsDetailsPage> createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(GetNewsDetailsEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: BuildAppBar(),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state.status == NewsStatus.loading ||
              state.newsDetails == null) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }

          if (state.status == NewsStatus.success) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildReturnButton(context),
                  _buildCategoryAndFavorite(size, state),
                  _buildNewsContent(size, state),
                  _buildRelatedNews(size, state),
                  BuildAppFooter(),
                ],
              ),
            );
          }

          return SizedBox.shrink();
        }
      ),
    );
  }

  Widget _buildNewsContent(Size size, NewsState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),

        // Title
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Text(
            state.newsDetails!.title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 20),

        // PublishedAt
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Text(_getPublishedDate(state)),
        ),
        SizedBox(height: 20),

        // Image
        Image.network(
          state.newsDetails!.image.src,
          width: double.infinity,
          height: size.height * 0.3,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 8),
        Center(
          child: Text(
            state.newsDetails!.image.alt,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textGray,
            ),
          ),
        ),
        SizedBox(height: 20),

        // Resume
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 26,
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.backgroundGray,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                width: 1,
                color: AppColors.borderGray,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Resumo NortusAI',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 14),
                Text(
                  state.newsDetails!.newsResume,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textGray
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 30),

        // Description
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 26,
          ),
          child: Text(
            state.newsDetails!.description,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textBlack,
            ),
          ),
        ),
        SizedBox(height: 30),

        // Categories
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 26,
          ),
          child: Row(
            children: List.generate(
              state.newsDetails!.categories.length,
              (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundGray,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: 1,
                        color: AppColors.borderGray,
                      ),
                    ),
                    child: Text(
                      state.newsDetails!.categories[index].name,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textBlack,
                      ),
                    ),
                  ),
                );
            }),
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }

  Widget _buildRelatedNews(Size size, NewsState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 26,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 16,
              top: 20,
              bottom: 20,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.backgroundGray,
              border: Border.all(
                width: 1,
                color: AppColors.borderGray,
              ),
            ),
            child: Text(
              'Notícias relacionadas',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: AppColors.textBlack,
              ),
            )
          ),
          SizedBox(height: 30),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              childAspectRatio: 0.6,
            ),
            itemCount: state.newsDetails!.relatedNews.length,
            itemBuilder: (context, index) {
              final related = state.newsDetails!.relatedNews[index];
              return BuildRelatedNewsCard(relatedNews: related);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryAndFavorite(Size size, NewsState state) {
    final bool isFavorite = state.favoriteNews.any((n) => n == state.newsDetails!.id);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: AppColors.backgroundGray,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                width: 1,
                color: AppColors.secondary,
              ),
            ),
            child: Text(
              state.newsDetails!.categories.first.name,
              style: TextStyle(
                color: AppColors.textBlack,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (isFavorite) {
                context.read<NewsBloc>().add(
                  RemoveFavoriteNewsEvent(id: widget.id),
                );
              } else {
                  context.read<NewsBloc>().add(
                    AddFavoriteNewsEvent(id: widget.id),
                  );
              }
            },
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.backgroundGray,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  width: 1,
                  color: AppColors.borderGray,
                ),
              ),
              child: Icon(
                isFavorite
                    ? Icons.star_rounded
                    : Icons.star_outline_rounded,
                color: isFavorite
                    ? AppColors.yellow
                    : AppColors.textBlack,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReturnButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 30,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              context.go(AppRoutes.news);
            },
            child: Icon(
              Icons.arrow_back_rounded,
              color: AppColors.primary,
            ),
          ),
          SizedBox(width: 10),
          Text(
            'Voltar',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _getPublishedDate(NewsState state) {
    final publishedAt = state.newsDetails!.publishedAt;

    final day = publishedAt.day.toString().padLeft(2, '0');
    final month = publishedAt.month.toString().padLeft(2, '0');
    final year = publishedAt.year.toString();

    final hour = publishedAt.hour.toString().padLeft(2, '0');
    final minute = publishedAt.minute.toString().padLeft(2, '0');

    return 'Publicado: $day/$month/$year às $hour:$minute';
  }
}