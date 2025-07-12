import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8000"; // Localhost for emulator

  static Future<Map<String, String>> _getHeaders() async {
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  static Future<Map<String, dynamic>> getProtectedData() async {
    final response = await http.get(
      Uri.parse('$baseUrl/protected'),
      headers: await _getHeaders(),
    );
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> createProfile(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create-profile'),
      headers: await _getHeaders(),
      body: json.encode(data),
    );
    return json.decode(response.body);
  }
}