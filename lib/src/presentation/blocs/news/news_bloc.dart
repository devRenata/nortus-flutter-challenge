import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nortus/src/domain/exceptions/app_exception.dart';
import 'package:nortus/src/domain/usecases/news/get_categories_usecase.dart';
import 'package:nortus/src/presentation/blocs/news/news_event.dart';
import 'package:nortus/src/presentation/blocs/news/news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetCategoriesUsecase getCategoriesUsecase;

  NewsBloc({
    required this.getCategoriesUsecase,
  }) : super(NewsState.initial()) {
    on<LoadNewsDataEvent>(_onLoadNewsData);
  }

  Future<void> _onLoadNewsData(
    LoadNewsDataEvent event,
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