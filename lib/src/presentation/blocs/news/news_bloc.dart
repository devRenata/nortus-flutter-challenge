import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nortus/src/domain/exceptions/app_exception.dart';
import 'package:nortus/src/domain/usecases/news/get_categories_usecase.dart';
import 'package:nortus/src/domain/usecases/news/get_news_usecase.dart';
import 'package:nortus/src/presentation/blocs/news/news_event.dart';
import 'package:nortus/src/presentation/blocs/news/news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetCategoriesUsecase getCategoriesUsecase;
  final GetNewsUsecase getNewsUsecase;

  NewsBloc({
    required this.getCategoriesUsecase,
    required this.getNewsUsecase,
  }) : super(NewsState.initial()) {
    on<LoadCategoriesEvent>(_onLoadCategories);
    on<GetNewsEvent>(_onGetNews);
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