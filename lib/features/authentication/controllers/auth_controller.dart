import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthController extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> login(String email, String password, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final success = await _authService.login(email, password);
    _isLoading = false;
    notifyListeners();

    return success;
  }

  Future<bool> createAccount(String name, String email, String password, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final success = await _authService.createAccount(name, email, password);
    _isLoading = false;
    notifyListeners();

    return success;
  }
}
