import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nortus/src/presentation/blocs/news/news_bloc.dart';
import 'package:nortus/src/presentation/blocs/news/news_event.dart';
import 'package:nortus/src/presentation/blocs/news/news_state.dart';
import 'package:nortus/src/presentation/pages/widgets/build_app_bar.dart';
import 'package:nortus/src/presentation/pages/widgets/build_app_drawer.dart';
import 'package:nortus/src/presentation/themes/app_colors.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(LoadNewsDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: BuildAppBar(),
      drawer: BuildAppDrawer(),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state.status == NewsStatus.loading ||
              state.status == NewsStatus.initial) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }

          if (state.status == NewsStatus.success) {
            return SafeArea(
              child: Column(
                children: [
                  _buildSearchBar(size),
                ],
              ),
            );
          }

          return SizedBox.shrink();
        }
      ),
    );
  }

  Widget _buildSearchBar(Size size) {
    return Container(
      height: size.height * 0.09,
      width: double.infinity,
      color: AppColors.backgroundGray,
      child: Row(
        children: [
          Builder(
            builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.menu_rounded, size: 28),
              );
            },
          ),
          SizedBox(width: 10),
          Text(
            'Nortus',
            style: TextStyle(
              color: AppColors.textBlack,
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search_rounded, size: 28),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
