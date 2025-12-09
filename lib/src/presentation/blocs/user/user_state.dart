import 'package:nortus/src/domain/entities/user.dart';

enum UserStatus { initial, loading, success, failure }

class UserState {
  final UserStatus status;
  final User? user;
  final String? message;

  UserState({
    required this.status,
    required this.user,
    required this.message,
  });
  
  factory UserState.initial() {
    return UserState(
      status: UserStatus.initial,
      user: null,
      message: null,
    );
  }

  UserState copyWith({
    UserStatus? status,
    User? user,
    String? message,
  }) {
    return UserState(
      status: status ?? this.status,
      user: user,
      message: message,
    );
  }
}
