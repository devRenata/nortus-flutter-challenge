import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nortus/src/domain/entities/news.dart';
import 'package:nortus/src/presentation/blocs/news/news_bloc.dart';
import 'package:nortus/src/presentation/blocs/news/news_event.dart';
import 'package:nortus/src/presentation/blocs/news/news_state.dart';
import 'package:nortus/src/presentation/pages/news/widgets/build_news_card.dart';
import 'package:nortus/src/presentation/pages/news/widgets/build_search_news.dart';
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
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(LoadCategoriesEvent());
    context.read<NewsBloc>().add(GetNewsEvent());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (isSearching) return;
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
                      
                      // Listview of News
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            final newsList = _listToShow(state);

                            if (newsList.isEmpty) {
                              if (isSearching) {
                                return _buildEmptySearchResult();
                                
                              } else {
                                // List of news loading
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                  ),
                                );
                              }
                            }

                            // List of news
                            return ListView.builder(
                              controller: _scrollController,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              itemCount: _listToShow(state).length +
                                  ((state.status == NewsStatus.loadingNews && !isSearching) ? 1 : 0),
                              itemBuilder: (context, index) {
                                final newsList = _listToShow(state);
                            
                                if (index < newsList.length) {
                                  return BuildNewsCard(
                                    news: newsList[index],
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
                            );
                          }
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

  List<News> _listToShow(NewsState state) {
    return isSearching ? state.searchedNews : state.news;
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

          if (isSearching)
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: BuildSearchNews(
                        controller: _searchController,
                        onChanged: (value) {
                          context.read<NewsBloc>().add(SearchNewsEvent(query: value));
                        },
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() => isSearching = false);
                      },
                      child: Container(
                        width: size.width * 0.1,
                        height: size.width * 0.1,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundGray,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            width: 1,
                            color: AppColors.borderGray,
                          ),
                        ),
                        child: Icon(
                          Icons.close_rounded,
                        ),
                      ),
                    ),
                  ),
                  
                ],
              ),
            )
          else
            Expanded(
              child: Row(
                children: [
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
                    onPressed: () {
                      setState(() {
                        isSearching = true;
                      });
                    },
                    icon: Icon(Icons.search_rounded, size: 28),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            )
        ],
      ),
    );
  }

  Widget _buildEmptySearchResult() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Resultado da busca por ',
                  style: TextStyle(
                    color: AppColors.textBlack,
                    fontSize: 16,
                  ),
                ),
                TextSpan(
                  text: _searchController.text,
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Verifique se existe algum erro de digitação no termo.',
            style: TextStyle(
              color: AppColors.textGray,
            ),
          )
        ],
      ),
    );
  }
}
