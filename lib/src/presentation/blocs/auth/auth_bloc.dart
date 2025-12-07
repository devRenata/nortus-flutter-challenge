import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nortus/src/domain/exceptions/app_exception.dart';
import 'package:nortus/src/domain/usecases/auth/login_usecase.dart';
import 'package:nortus/src/presentation/blocs/auth/auth_event.dart';
import 'package:nortus/src/presentation/blocs/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;

  AuthBloc({
    required this.loginUsecase,
  }) : super(AuthState()) {
    on<SubmitLoginEvent>(_onSubmitLogin);
  }

  Future<void> _onSubmitLogin(
    SubmitLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final loginSuccessful = await loginUsecase(
        login: event.login,
        password: event.password,
        keepLogged: event.keepLogged,
      );

      if (loginSuccessful) {
        emit(state.copyWith(status: AuthStatus.success));
      } else {
        emit(state.copyWith(status: AuthStatus.failure));
      }

    } on AppException catch (e) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        message: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        message: 'Ocorreu um erro ao realizar o login, tente novamente.',
      ));
    }
  }
}