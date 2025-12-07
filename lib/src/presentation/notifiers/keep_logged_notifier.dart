import 'package:flutter/material.dart';
import 'package:nortus/src/domain/usecases/auth/get_keep_logged_usecase.dart';

class KeepLoggedNotifier extends ChangeNotifier {
  final GetKeepLoggedUsecase getKeepLoggedUsecase;

  bool? _isLogged;
  bool? get isLogged => _isLogged;

  KeepLoggedNotifier({
    required this.getKeepLoggedUsecase,
  }) {
    _init();
  }

  Future<void> _init() async {
    _isLogged = await getKeepLoggedUsecase();
    notifyListeners();
  }
}