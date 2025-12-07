enum AuthStatus {
  initial,
  loading,
  signInSuccessful,
  signUpSuccessful,
  failure,
}

class AuthState {
  final AuthStatus status;
  final String? message;

  AuthState({
    this.status = AuthStatus.initial,
    this.message,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? message,
  }) {
    return AuthState(
      status: status ?? this.status,
      message: message,
    );
  }
}