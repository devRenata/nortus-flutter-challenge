import 'package:nortus/src/data/datasources/auth_local_datasource.dart';
import 'package:nortus/src/data/datasources/auth_remote_datasource.dart';
import 'package:nortus/src/domain/exceptions/app_exception.dart';
import 'package:nortus/src/domain/exceptions/sign_in_exception.dart';
import 'package:nortus/src/domain/exceptions/sign_up_exception.dart';
import 'package:nortus/src/domain/repositories/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  final AuthLocalDatasource authLocalDatasource;

  AuthRepositoryImp({
    required this.authRemoteDatasource,
    required this.authLocalDatasource,
  });

  @override
  Future<bool> signUp({required String login, required String password}) async {
    try {
      return await authRemoteDatasource.signUp(
        login: login,
        password: password,
      );
    } on AppException {
      rethrow;
    } catch (e) {
      throw SignUpException();
    }
  }
  
  @override
  Future<bool> signIn({
    required String login,
    required String password,
    required bool keepLogged,
  }) async {
    try {
      final isSuccessful = await authRemoteDatasource.signIn(
        login: login,
        password: password,
      );

      if (isSuccessful && keepLogged) {
        await authLocalDatasource.saveKeepLogged(true);
      }

      return isSuccessful;
    } on AppException {
      rethrow;
    } catch (e) {
      throw SignInException();
    }
  }
  
  @override
  Future<bool> getKeepLogged() async {
    return await authLocalDatasource.getKeepLogged();
  }
  
  @override
  Future<void> logout() async {
    await authLocalDatasource.clearKeepLogged();
  }
}