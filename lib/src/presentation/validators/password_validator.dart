import 'package:nortus/src/domain/exceptions/different_passwords_exception.dart';
import 'package:nortus/src/domain/exceptions/empty_password_exception.dart';
import 'package:nortus/src/domain/exceptions/no_letter_in_password_exception.dart';
import 'package:nortus/src/domain/exceptions/no_number_in_password_exception.dart';
import 'package:nortus/src/domain/exceptions/short_password_exception.dart';
import 'package:nortus/src/domain/exceptions/white_space_in_password_exception.dart';

class PasswordValidator {
  static String? signInValidate({String? password}) {
    if (password == null || password.isEmpty) {
      return EmptyPasswordException().message;
    }

    return null;
  }

  static String? signUpValidate({String? password}) {
    if (password == null || password.isEmpty) {
      return EmptyPasswordException().message;
    }

    if (RegExp(r'^[a-zA-Z]+$').hasMatch(password)) {
      return NoLetterInPasswordException().message;
    }

    if (!RegExp(r'\d').hasMatch(password)) {
      return NoNumberInPasswordException().message;
    }

    if (password.contains(' ')) {
      return WhiteSpaceInPasswordException().message;
    }

    if (password.length < 8) {
      return ShortPasswordException().message;
    }

    return null;
  }

  static String? signUpRepeatValidate({
    String? password,
    String? repeatPassword,
  }) {
    if (password == null || password.isEmpty) {
      return EmptyPasswordException().message;
    }

    if (password != repeatPassword) {
      return DifferentPasswordsException().message;
    }

    return null;
  }
}