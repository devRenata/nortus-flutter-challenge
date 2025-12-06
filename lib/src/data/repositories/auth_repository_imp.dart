import 'package:nortus/src/data/datasources/auth_remote_datasource.dart';
import 'package:nortus/src/domain/exceptions/app_exception.dart';
import 'package:nortus/src/domain/exceptions/signin_exception.dart';
import 'package:nortus/src/domain/exceptions/signup_exception.dart';
import 'package:nortus/src/domain/repositories/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  AuthRepositoryImp({required this.authRemoteDatasource});

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
  Future<bool> signIn({required String login, required String password}) async {
    try {
      return await authRemoteDatasource.signIn(
        login: login,
        password: password,
      );
    } on AppException {
      rethrow;
    } catch (e) {
      throw SigninException();
    }
  }
}