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
      {String? schoolId, List<int>? schoolGroupsIds}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'first_name': firstName,
        'last_name': lastName,
        'school': schoolId,
        'school_groups_ids': schoolGroupsIds,
      }),
    );

    if (response.statusCode == 200) {

    } else {
      throw Exception('Registration failed');
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
