import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  static const String _isLoggedKey = 'is_logged_in';

  Future<void> saveKeepLogged(bool isLogged) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedKey, isLogged);
  }

  Future<bool> getKeepLogged() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedKey) ?? false;
  }

  Future<void> clearKeepLogged() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedKey, false);
  }
}