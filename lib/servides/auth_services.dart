import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_model.dart';


class AuthService {
  static final AuthService _instance = AuthService._internal();

  factory AuthService() => _instance;

  AuthService._internal();

  User? currentUser;

  Future<bool> login(String email, String password) async {
    // This is the Hardcoded credentials
    if (email == 'intern@balancee.com' && password == 'Intern123#') {
      // this is the dummy token
      final token = 'dummy_token_${DateTime.now().millisecondsSinceEpoch}';
      currentUser = User(email: email, token: token);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userToken', token);
      await prefs.setString('userEmail', email);

      return true;
    }
    return false;
  }

  Future<bool> isLoggedIn() async {
    if (currentUser != null) return true;

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('userToken');
    final email = prefs.getString('userEmail');

    if (token != null && email != null) {
      currentUser = User(email: email, token: token);
      return true;
    }

    return false;
  }

  Future<void> logout() async {
    currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userToken');
    await prefs.remove('userEmail');
  }
}