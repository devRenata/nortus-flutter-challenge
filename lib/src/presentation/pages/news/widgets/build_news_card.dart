import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nortus/src/domain/entities/news.dart';
import 'package:nortus/src/presentation/blocs/news/news_bloc.dart';
import 'package:nortus/src/presentation/blocs/news/news_event.dart';
import 'package:nortus/src/presentation/blocs/news/news_state.dart';
import 'package:nortus/src/presentation/themes/app_colors.dart';

class BuildNewsCard extends StatefulWidget {
  final News news;

  const BuildNewsCard({
    required this.news,
    super.key,
  });

  @override
  State<BuildNewsCard> createState() => _BuildNewsCardState();
}

class _BuildNewsCardState extends State<BuildNewsCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        final bool isFavorite = state.favoriteNews.any((n) => n == widget.news.id);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    context.pushNamed(
                      'newsDetails',
                      pathParameters: {
                        'id': widget.news.id.toString(),
                      }
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.news.image.src,
                      width: double.infinity,
                      height: size.height * 0.24,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: size.width * 0.11,
                    height: size.width * 0.11,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        if (isFavorite) {
                          context.read<NewsBloc>().add(
                            RemoveFavoriteNewsEvent(id: widget.news.id),
                          );
                        } else {
                          context.read<NewsBloc>().add(
                            AddFavoriteNewsEvent(id: widget.news.id),
                          );
                        }
                      },
                      child: Icon(
                        isFavorite
                            ? Icons.star_rounded
                            : Icons.star_border_rounded,
                        color: isFavorite
                            ? AppColors.yellow
                            : AppColors.textBlack,
                        size: 28,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            Text(
              widget.news.categories.first.name.toUpperCase(),
              style: TextStyle(
                color: AppColors.textGray,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 4),
            Text(
              widget.news.title,
              style: TextStyle(
                color: AppColors.textBlack,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(height: 8),
            Text(
              widget.news.summary,
              style: TextStyle(
                color: AppColors.textGray,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text(
              _getPublishedDate(),
              style: TextStyle(
                color: AppColors.textGray,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 22),
          ],
        );
      }
    );
  }

  String _getPublishedDate() {
    final publishedAt = widget.news.publishedAt;
    final now = DateTime.now();

    final difference = now.difference(publishedAt);

    if (difference.inSeconds < 60) {
      return 'Agora';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutos atrás';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} horas atrás';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} dias atrás';
    } else {
      return '${publishedAt.day.toString().padLeft(2, '0')}/'
            '${publishedAt.month.toString().padLeft(2, '0')}/'
            '${publishedAt.year}';
    }
  }
}