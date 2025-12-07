import 'package:nortus/src/domain/exceptions/empty_email_exception.dart';
import 'package:nortus/src/domain/exceptions/invalid_email_exception.dart';

class EmailValidator {
  static String? signInValidate({String? email}) {
    if (email == null || email.isEmpty) {
      return EmptyEmailException().message;
    }
    
    return null;
  }

  static String? signUpValidate({String? email}) {
    if (email == null || email.isEmpty) {
      return EmptyEmailException().message;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return InvalidEmailException().message;
    }
    return null;
  }
}