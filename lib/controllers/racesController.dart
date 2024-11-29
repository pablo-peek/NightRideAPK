import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RacesController {
  Future<List<dynamic>> getAllRacers(BuildContext context, int raceNumber, int page, int limit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token'); 
    if (token != null) {
      final response = await http.get(
        Uri.parse("${dotenv.env['FLUTTER_APP_ROBUST_API_BASE_URL']}/user/all-users-races?raceNumber=${raceNumber}&page=$page&limit=$limit"),
        headers: <String, String>{
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> data = responseData['data']; 
        return data;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al obtener los corredores")),
        );
        return [];
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Token no encontrado")),
      );
      return [];
    }
  }
}