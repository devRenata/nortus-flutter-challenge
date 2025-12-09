abstract class AuthEvent {}

class SubmitLoginEvent extends AuthEvent {
  final String login;
  final String password;
  final bool keepLogged;

  SubmitLoginEvent({
    required this.login,
    required this.password,
    required this.keepLogged,
  });
}

class CreateAccountEvent extends AuthEvent {
  final String login;
  final String password;
 
  CreateAccountEvent({
    required this.login,
    required this.password,
  });
}

class LogoutEvent extends AuthEvent {}
