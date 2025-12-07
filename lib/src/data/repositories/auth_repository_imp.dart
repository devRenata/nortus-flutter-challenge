import 'package:nortus/src/data/datasources/auth_local_datasource.dart';
import 'package:nortus/src/data/datasources/auth_remote_datasource.dart';
import 'package:nortus/src/domain/exceptions/app_exception.dart';
import 'package:nortus/src/domain/exceptions/signin_exception.dart';
import 'package:nortus/src/domain/exceptions/signup_exception.dart';
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
      throw SignupException();
    }
  }
  
  @override
  Future<bool> signIn({
    required String login,
    required String password,
    required bool keepLogged,
  }) async {
    try {
      final isSusseccful = await authRemoteDatasource.signIn(
        login: login,
        password: password,
      );

      if (isSusseccful && keepLogged) {
        await authLocalDatasource.saveKeepLogged(true);
      }

      return isSusseccful;
    } on AppException {
      rethrow;
    } catch (e) {
      throw SigninException();
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