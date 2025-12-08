import 'package:nortus/src/domain/entities/user.dart';
import 'package:nortus/src/domain/repositories/user_repository.dart';

class GetUserUsecase {
  final UserRepository repository;
  GetUserUsecase({required this.repository});

  Future<User> call() async {
    return await repository.getUser();
  }
}