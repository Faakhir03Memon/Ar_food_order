import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _authService.userStatus.listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    final result = await _authService.signIn(email, password);
    _isLoading = false;
    notifyListeners();
    return result != null;
  }

  Future<void> logout() async {
    await _authService.signOut();
  }
}
