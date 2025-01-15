import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plant_puzzle_app/models/visitors.dart';
import '../utilities/user_storage.dart';

class ApiService {
  final String baseUrl = "http://192.168.68.111:8001/visitors/api";

  Future<Visitor> getVisitor(int visitorId) async {
    final response = await http.get(Uri.parse('$baseUrl/$visitorId/'));
    if (response.statusCode == 200) {
      return Visitor.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load visitor');
    }
  }

  Future<void> loginUser(String username) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await saveUser(data['visitor_id']);
    } else {
      throw Exception('Login failed');
    }
  }

Future<void> registerUser(Visitor visitor) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(visitor.toJson()),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      await saveUser(data['visitor_id']);
    } else {
      throw Exception('Registration failed.');
    }
  }
  
  Future<bool> isUsernameTaken(String username) async {
    final response = await http.get(
      Uri.parse('$baseUrl/username-check/$username'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['is_taken'];
    } else {
      throw Exception('Chyba při ověřování uživatelského jména.');
    }
  }

  Future<List<dynamic>> getSchoolGroups() async {
    final response = await http.get(Uri.parse('$baseUrl/school-groups'));

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Chyba při načítání školních skupin.');
    }
  }
}
