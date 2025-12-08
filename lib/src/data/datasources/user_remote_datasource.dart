import 'package:dio/dio.dart';
import 'package:nortus/src/data/http/dio_error_handler.dart';
import 'package:nortus/src/data/http/endpoints.dart';
import 'package:nortus/src/domain/entities/user.dart';
import 'package:nortus/src/domain/exceptions/get_user_exception.dart';

class UserRemoteDatasource {
  final Dio dio;
  UserRemoteDatasource({required this.dio});
  
  Future<User> getUser() async {
    try {
      await Future.delayed(Duration(seconds: 3));

      final response = await dio.get(Endpoints.user);

      if (response.statusCode == 200) {
        final data = response.data['data'] as Map<String, dynamic>;
        return User.fromJson(data);
      } else {
        throw GetUserException();
      }

    } on DioException catch (e) {
      throw DioErrorHandler.handle(e);
    } catch (e) {
      throw GetUserException();
    }
  }
}