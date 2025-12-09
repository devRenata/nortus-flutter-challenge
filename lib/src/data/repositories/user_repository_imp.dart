import 'package:nortus/src/data/datasources/user_remote_datasource.dart';
import 'package:nortus/src/domain/entities/user.dart';
import 'package:nortus/src/domain/exceptions/app_exception.dart';
import 'package:nortus/src/domain/exceptions/get_user_exception.dart';
import 'package:nortus/src/domain/repositories/user_repository.dart';

class UserRepositoryImp implements UserRepository {
  final UserRemoteDatasource userRemoteDatasource;
  UserRepositoryImp({required this.userRemoteDatasource});

  @override
  Future<User> getUser() async {
    try {
      return await userRemoteDatasource.getUser();
    } on AppException {
      rethrow;
    } catch (e) {
      throw GetUserException();
    }
  }
}