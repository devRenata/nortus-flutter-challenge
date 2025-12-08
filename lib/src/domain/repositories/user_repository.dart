import 'package:nortus/src/domain/entities/user.dart';

abstract class UserRepository {
  Future<User> getUser();
}