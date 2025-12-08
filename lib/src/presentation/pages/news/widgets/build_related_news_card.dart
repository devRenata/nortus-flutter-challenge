import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nortus/src/domain/entities/related_news.dart';
import 'package:nortus/src/presentation/themes/app_colors.dart';

class BuildRelatedNewsCard extends StatefulWidget {
  final RelatedNews relatedNews;

  const BuildRelatedNewsCard({
    required this.relatedNews,
    super.key,
  });

  @override
  State<BuildRelatedNewsCard> createState() => _BuildRelatedNewsCardState();
}

class _BuildRelatedNewsCardState extends State<BuildRelatedNewsCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image
        SizedBox(
          height: size.height * 0.16,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  context.pushNamed(
                    'newsDetails',
                    pathParameters: {
                      'id': widget.relatedNews.id.toString(),
                    },
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.relatedNews.imageUrl,
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
                      setState(() {
                        isFavorite = !isFavorite;
                      });
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
        ),
        SizedBox(height: 10),
    
        // Category
        Text(
          widget.relatedNews.categories.first.name.toUpperCase(),
          style: TextStyle(
            color: AppColors.textGray,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 4),
    
        // Title
        Text(
          widget.relatedNews.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.textBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
    
        // PublishedAt
        Text(
          _getPublishedDate(),
          style: TextStyle(
            color: AppColors.textGray,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  String _getPublishedDate() {
    final publishedAt = widget.relatedNews.publishedAt;
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