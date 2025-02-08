import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/visitors.dart';
import '../utilities/user_storage.dart';
import 'data_service.dart';

class ApiService {
  final String baseUrl;
  final String visitorUrl;
  final DataService dataService = DataService();

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

  /// Saves a new user with the provided visitor information.
  /// Saves the visitor ID locally.
  Future<void> saveUser(Visitor visitor) async {
    final response = await http.post(
      Uri.parse('$visitorUrl/create/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(visitor.toJson()),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      await dataService.saveUserId(data['visitor_id']);
    } else {
      throw Exception('Registration failed.');
    }
  }

  Future<void> updateVisitor(Visitor visitor) async {
    try {
      final url = Uri.parse('$visitorUrl/${visitor.id}/update/');
      await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(visitor.toJson()),
      );

    } catch (e) {
      throw Exception('Failed to update visitor: $e');
    }
  }

  /// Retrieves a list of school groups from the API.
  Future<List<dynamic>> getSchoolGroups() async {
    final response = await http.get(Uri.parse('$visitorUrl/school-groups/'));

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