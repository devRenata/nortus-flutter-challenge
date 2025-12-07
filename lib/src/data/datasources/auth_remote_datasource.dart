import 'package:dio/dio.dart';
import 'package:nortus/src/data/http/dio_error_handler.dart';
import 'package:nortus/src/data/http/endpoints.dart';
import 'package:nortus/src/domain/exceptions/invalid_login_exception.dart';
import 'package:nortus/src/domain/exceptions/signin_exception.dart';
import 'package:nortus/src/domain/exceptions/user_already_exist_exception.dart';

class AuthRemoteDatasource {
  final Dio dio;
  AuthRemoteDatasource({required this.dio});

  final List<Map<String, String>> _users = [];
  
  Future<bool> signUp({required String login, required String password}) async {
    await Future.delayed(Duration(seconds: 3));

    final isUserAlreadyExist = _users.any((user) => user['login'] == login);
    if (isUserAlreadyExist) {
      throw UserAlreadyExistException();
    }

    final newUser = {
      'login': login,
      'password': password,
    };

    _users.add(newUser);

    return true;
  }

  Future<bool> signIn({required String login, required String password}) async {
    try {
      await Future.delayed(Duration(seconds: 3));

      final isUserAlreadyExist = _users.any((user) => user['login'] == login);
      if (isUserAlreadyExist) {
        final user = _users.firstWhere((user) => user['login'] == login);

        final isCorrectPassword = user['password'] == password;
        if (isCorrectPassword) {
          return true;
        } else {
          throw InvalidLoginException();
        }
      }

      final response = await dio.post(
        Endpoints.auth,
        data: {
          "login": login,
          "password": password,
        },
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw InvalidLoginException();
      }
      throw DioErrorHandler.handle(e);
    } catch (e) {
      throw SigninException();
    }
  }
}