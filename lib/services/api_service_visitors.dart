import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utilities/user_storage.dart';

class ApiService {
  final String baseUrl = "http://192.168.68.111:8001/visitors/api";

  Future<void> loginUser(String username) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await saveUser(data['visitor_id'], username);
    } else {
      throw Exception('Login failed');
    }
  }

  Future<void> registerUser(String username, String firstName, String lastName,
      String schoolId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'first_name': firstName,
        'last_name': lastName,
        'school': schoolId,
      }),
    );

    if (response.statusCode == 201) {
      print('Registration successful');
    } else {
      throw Exception('Registration failed');
    }
  }
}
