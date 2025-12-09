import 'package:nortus/src/domain/entities/user.dart';

abstract class UserEvent {}

class LoadUserEvent extends UserEvent {}

class UpdateUserEvent extends UserEvent {
  final User updatedUser;
  UpdateUserEvent({required this.updatedUser});
}