import 'package:nortus/src/domain/repositories/auth_repository.dart';

class GetKeepLoggedUsecase {
  final AuthRepository repository;
  GetKeepLoggedUsecase({required this.repository});

  Future<bool> call() async {
    return await repository.getKeepLogged();
  }
}