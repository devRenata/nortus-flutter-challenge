enum AuthStatus { initial, loading, success, failure }

class AuthState {
  final AuthStatus status;
  final String? message;

  AuthState({
    this.status = AuthStatus.initial,
    this.message,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}