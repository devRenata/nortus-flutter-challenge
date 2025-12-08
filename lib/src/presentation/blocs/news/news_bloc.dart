import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nortus/src/domain/exceptions/app_exception.dart';
import 'package:nortus/src/domain/usecases/news/get_categories_usecase.dart';
import 'package:nortus/src/domain/usecases/news/get_news_details_usecase.dart';
import 'package:nortus/src/domain/usecases/news/get_news_usecase.dart';
import 'package:nortus/src/presentation/blocs/news/news_event.dart';
import 'package:nortus/src/presentation/blocs/news/news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetCategoriesUsecase getCategoriesUsecase;
  final GetNewsDetailsUsecase getNewsDetailsUsecase;
  final GetNewsUsecase getNewsUsecase;

  NewsBloc({
    required this.getNewsDetailsUsecase,
    required this.getCategoriesUsecase,
    required this.getNewsUsecase,
  }) : super(NewsState.initial()) {
    on<LoadCategoriesEvent>(_onLoadCategories);
    on<GetNewsEvent>(_onGetNews);
    on<GetNewsDetailsEvent>(_onGetNewsDetails);
    on<AddFavoriteNewsEvent>(_onAddFavoriteNews);
    on<RemoveFavoriteNewsEvent>(_onRemoveFavoriteNews);
  }

  Future<void> _onRemoveFavoriteNews(
    RemoveFavoriteNewsEvent event,
    Emitter<NewsState> emit,
  ) async {
    final updatedList = state.favoriteNews.where((favId) => favId != event.id).toList();
    emit(state.copyWith(favoriteNews: updatedList));
  }

  Future<void> _onAddFavoriteNews(
    AddFavoriteNewsEvent event,
    Emitter<NewsState> emit,
  ) async {
    if (state.favoriteNews.contains(event.id)) return;

    final updatedList = List<int>.from(state.favoriteNews)..add(event.id);
    emit(state.copyWith(
      favoriteNews: updatedList,
      message: 'Você favoritou esta Notícia. Você pode encontrá-la no perfil.'
    ));
  }

  Future<void> _onGetNewsDetails(
    GetNewsDetailsEvent event,
    Emitter<NewsState> emit,
  ) async {
    emit(state.copyWith(
      status: NewsStatus.loading,
      newsDetails: null,
    ));

    try {
      final newsDetails = await getNewsDetailsUsecase(id: event.id);

      emit(state.copyWith(
        status: NewsStatus.success,
        newsDetails: newsDetails,
      ));

    } on AppException catch (e) {
      emit(state.copyWith(
        status: NewsStatus.failure,
        message: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: NewsStatus.failure,
        message: 'Ocorreu um erro ao carregar os detalhes da notícia, tente novamente.',
      ));
    }
  }

  Future<void> _onGetNews(
    GetNewsEvent event,
    Emitter<NewsState> emit,
  ) async {
    if (state.hasReachedMax) return;

    emit(state.copyWith(status: NewsStatus.loadingNews));

    try {
      final news = await getNewsUsecase(page: state.page);

      emit(state.copyWith(
        status: NewsStatus.success,
        news: List.of(state.news)..addAll(news),
        page: state.page + 1,
        hasReachedMax: news.isEmpty,
      ));

    } on AppException catch (e) {
      emit(state.copyWith(
        status: NewsStatus.failure,
        message: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: NewsStatus.failure,
        message: 'Ocorreu um erro ao carregar as notícias, tente novamente.',
      ));
    }
  }

  Future<void> _onLoadCategories(
    LoadCategoriesEvent event,
    Emitter<NewsState> emit,
  ) async {
    emit(state.copyWith(status: NewsStatus.loading));

    try {
      final categories = await getCategoriesUsecase();

      emit(state.copyWith(
        status: NewsStatus.success,
        categories: categories,
      ));

    } on AppException catch (e) {
      emit(state.copyWith(
        status: NewsStatus.failure,
        message: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: NewsStatus.failure,
        message: 'Ocorreu um erro ao carregar os dados, tente novamente.',
      ));
    }
  }
}