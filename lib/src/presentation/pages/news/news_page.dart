import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nortus/src/presentation/blocs/news/news_bloc.dart';
import 'package:nortus/src/presentation/blocs/news/news_event.dart';
import 'package:nortus/src/presentation/blocs/news/news_state.dart';
import 'package:nortus/src/presentation/pages/news/widgets/build_news_card.dart';
import 'package:nortus/src/presentation/pages/widgets/build_alert_widget.dart';
import 'package:nortus/src/presentation/pages/widgets/build_app_bar.dart';
import 'package:nortus/src/presentation/pages/widgets/build_app_drawer.dart';
import 'package:nortus/src/presentation/themes/app_colors.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(LoadCategoriesEvent());
    context.read<NewsBloc>().add(GetNewsEvent());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
      _scrollController.position.maxScrollExtent - 200) {
    
      final bloc = context.read<NewsBloc>();

      if (bloc.state.status != NewsStatus.loadingNews &&
          !bloc.state.hasReachedMax) {
        bloc.add(GetNewsEvent());
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: BuildAppBar(),
      drawer: BuildAppDrawer(),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          final isAlert = state.message != null;

          if (state.status == NewsStatus.loading ||
              state.status == NewsStatus.initial) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }

          if (state.status == NewsStatus.success ||
              state.status == NewsStatus.loadingNews) {
            return SafeArea(
              child: Stack(
                children: [
                  Column(
                    children: [
                      _buildSearchBar(size),
                      
                      Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          itemCount: state.news.length + (state.status == NewsStatus.loadingNews ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index < state.news.length) {
                              return BuildNewsCard(
                                news: state.news[index],
                              );
                            } else {
                              return Center(
                                child: Transform.scale(
                                  scale: 0.7,
                                  child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),

                  if (isAlert)
                    BuildAlertWidget(
                      message: state.message!,
                      type: state.status == NewsStatus.failure
                          ? ContentType.error
                          : ContentType.success,
                    ),
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
