import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? user;
  String role = 'user';

  Future<bool> login(String email, String password) async {
    user = await _authService.login(email, password);
    if (user != null) {
      role = await _authService.getUserRole(user!.uid);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> signUp(String email, String password) async {
    user = await _authService.signUp(email, password);
    role = 'user';
    notifyListeners();
    return user != null;
  }

  bool get isAdmin => role == 'admin';

  Future<void> logout() async {
    await _authService.logout();
    user = null;
    role = 'user';
    notifyListeners();
  }
}
