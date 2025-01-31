import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/visitors.dart';
import '../utilities/user_storage.dart';

class ApiService {
  final String baseUrl;
  final String visitorUrl;

  ApiService()
      : baseUrl = dotenv.env['BASE_URL'] ?? '',
        visitorUrl = '${dotenv.env['BASE_URL'] ?? ''}/visitors/api';

  
  /// Fetches a visitor by their ID from the API.
  /// Throws an exception if the request fails.
  Future<Visitor> getVisitor(int visitorId) async {
    final response = await http.get(Uri.parse('$visitorUrl/$visitorId/'));
    if (response.statusCode == 200) {
      return Visitor.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load visitor');
    }
  }

  /// Logs in a user with the given username.
  /// Saves the visitor ID locally on successful login.
  Future<void> loginUser(String username) async {
    final response = await http.post(
      Uri.parse('$visitorUrl/login/'),
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

  /// Registers a new user with the provided visitor information.
  /// Saves the visitor ID locally on successful registration.
  Future<void> registerUser(Visitor visitor) async {
    final response = await http.post(
      Uri.parse('$visitorUrl/register/'),
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

  /// Checks if a username is already taken.
  /// Returns true if the username is unavailable.
  Future<bool> isUsernameTaken(String username) async {
    final response = await http.get(
      Uri.parse('$visitorUrl/username-check/$username'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['is_taken'];
    } else {
      throw Exception('Error checking username availability.');
    }
  }

  /// Retrieves a list of school groups from the API.
  Future<List<dynamic>> getSchoolGroups() async {
    final response = await http.get(Uri.parse('$visitorUrl/school-groups'));

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Error loading school groups.');
    }
  }

  /// Submits visitor responses for a worksheet.
  /// Associates the responses with the logged-in user.
  Future<void> submitResponses(List<VisitorResponse> responses) async {
    final url = Uri.parse('$visitorUrl/submit-responses/');
    final visitorId = await getLoggedInUserId();

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'responses': responses.map((response) {
          return {
            ...response.toJson(),
            'visitor': visitorId,
          };
        }).toList()
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to submit responses for worksheet');
    }
  }

  /// Submits the success rate for a worksheet.
  Future<void> submitSuccessRate(SuccessRate rate) async {
    final url = Uri.parse('$visitorUrl/submit-success-rate/');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        ...rate.toJson(),
        'visitor': await getLoggedInUserId(),
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to submit success rate');
    }
  }
}