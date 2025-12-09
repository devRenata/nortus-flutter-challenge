import 'package:flutter/material.dart';
import 'package:nortus/src/domain/entities/news.dart';
import 'package:nortus/src/presentation/themes/app_colors.dart';

class BuildFavoriteNewsCard extends StatelessWidget {
  final News news;

  const BuildFavoriteNewsCard({
    required this.news,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            news.image.src,
            width: double.infinity,
            height: size.height * 0.18,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 10),
        Text(
          news.categories.first.name.toUpperCase(),
          style: TextStyle(
            color: AppColors.textGray,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 10),
        Text(
          news.title,
          style: TextStyle(
            color: AppColors.textBlack,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        SizedBox(height: 10),
        Text(
          news.summary,
          style: TextStyle(
            color: AppColors.textGray,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}