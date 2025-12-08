import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nortus/src/presentation/blocs/news/news_bloc.dart';
import 'package:nortus/src/presentation/blocs/news/news_state.dart';
import 'package:nortus/src/presentation/themes/app_colors.dart';

class BuildAppDrawer extends StatelessWidget {
  const BuildAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        return Drawer(
          backgroundColor: AppColors.backgroundGray,
          child: Column(
            children: [
              SizedBox(height: size.height * 0.1),
        
              // Header
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 22,
                    ),
                  ),
                  Text(
                    'Notícias',
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
        
              // Divider
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                  vertical: 10,
                ),
                child: Divider(),
              ),
        
              // Items
              Expanded(
                child: ListView.builder(
                  itemCount: state.categories.length + 1,
                  itemBuilder: (context, index) {
                    final allNewsIndex = 0;

                    if (index == allNewsIndex) {
                      return _buildDrawerItem('Todas as notícias', true, context);
                    } 

                    final category = state.categories[index - 1];
                    return _buildDrawerItem(category.name, false, context);
                  },
                ),
              )
            ],
          ),
        );
      }
    );
  }

  Widget _buildDrawerItem(String title, bool isSelected, BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: isSelected
              ? AppColors.secondary
              : AppColors.textBlack,
        ),
      ),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }
}