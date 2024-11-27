import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nightride/pages/login.dart';
import '../models/user.dart';
import '../pages/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  User? user;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
  }

  Future<void> login(BuildContext context, String email, String password) async {
    if (formKey.currentState!.validate()) {
      final response = await http.post(
        Uri.parse("${dotenv.env['FLUTTER_APP_ROBUST_API_BASE_URL']}/auth/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        user = User.fromJson(data);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Inicio de sesión exitoso")),
        );
        final String token = data['data']['token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al iniciar sesión")),
        );
      }
    }
  }

    Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginFormPage()),
    );
  }
}