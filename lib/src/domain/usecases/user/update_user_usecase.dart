import 'package:nortus/src/domain/entities/user.dart';

class UpdateUserUsecase {
  Future<User> call({required User updatedUser}) async {
    await Future.delayed(const Duration(seconds: 1));
    
    return updatedUser;
  }
}