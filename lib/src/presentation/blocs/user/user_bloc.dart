import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nortus/src/domain/exceptions/app_exception.dart';
import 'package:nortus/src/domain/usecases/user/get_user_usecase.dart';
import 'package:nortus/src/presentation/blocs/user/user_event.dart';
import 'package:nortus/src/presentation/blocs/user/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserUsecase getUserUsecase;

  UserBloc({
    required this.getUserUsecase
  }) : super(UserState.initial()) {
    on<LoadUserEvent>(_onLoadUser);
  }

  Future<void> _onLoadUser(
    LoadUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: UserStatus.loading));

    try {
      final user = await getUserUsecase();

      emit(state.copyWith(
        status: UserStatus.success,
        user: user,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: UserStatus.failure,
        message: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: UserStatus.failure,
        message: 'Ocorreu um erro ao carregar o usuário, tente novamente.',
      ));
    }
  }
}