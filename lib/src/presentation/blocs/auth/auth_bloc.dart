import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nortus/src/domain/exceptions/app_exception.dart';
import 'package:nortus/src/domain/usecases/auth/logout_usecase.dart';
import 'package:nortus/src/domain/usecases/auth/sign_in_usecase.dart';
import 'package:nortus/src/domain/usecases/auth/sign_up_usecase.dart';
import 'package:nortus/src/presentation/blocs/auth/auth_event.dart';
import 'package:nortus/src/presentation/blocs/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUsecase signInUsecase;
  final SignUpUsecase signUpUsecase;
  final LogoutUsecase logoutUsecase;

  AuthBloc({
    required this.signInUsecase,
    required this.signUpUsecase,
    required this.logoutUsecase,
  }) : super(AuthState()) {
    on<SubmitLoginEvent>(_onSubmitLogin);
    on<CreateAccountEvent>(_onCreateAccount);
    on<LogoutEvent>(_onLogoutEvent);
  }

  Future<void> _onLogoutEvent(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    await logoutUsecase();

    emit(state.copyWith(
      message: 'Você saiu da sua conta.',
    ));
  }

  Future<void> _onSubmitLogin(
    SubmitLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final signInSuccessful = await signInUsecase(
        login: event.login,
        password: event.password,
        keepLogged: event.keepLogged,
      );

      if (signInSuccessful) {
        emit(state.copyWith(
          status: AuthStatus.signInSuccessful,
          message: 'Login realizado com sucesso!',
        ));
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

  Future<void> _onCreateAccount(
    CreateAccountEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final signUpSuccessful = await signUpUsecase(
        login: event.login,
        password: event.password,
      );

      if (signUpSuccessful) {
        emit(state.copyWith(
          status: AuthStatus.signUpSuccessful,
          message: 'Conta criada com sucesso!',
        ));
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
        message: 'Ocorreu um erro ao realizar o cadastro, tente novamente.',
      ));
    }
  }
}