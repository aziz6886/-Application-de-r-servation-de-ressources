import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? user;

  // LOGIN
  Future<bool> login(String email, String password) async {
    user = await _authService.login(email, password);
    notifyListeners();
    return user != null;
  }

  // SIGN UP
  Future<bool> signUp(String email, String password) async {
    user = await _authService.signUp(email, password);
    notifyListeners();
    return user != null;
  }

  // LOGOUT
  Future<void> logout() async {
    await _authService.logout();
    user = null;
    notifyListeners();
  }
}
