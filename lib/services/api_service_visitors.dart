import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/visitors.dart';
import 'data_service_visitors.dart';

class ApiService {
  final String baseUrl;
  final String visitorUrl;
  final DataServiceVisitors dataService = DataServiceVisitors();

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
      dataService.saveUserId(data['visitor_id']);
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
  Future<List<SchoolGroup>> getSchoolGroups() async {
    final response = await http.get(Uri.parse('$visitorUrl/school-groups/'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      
      // Map JSON data to a list of SchoolGroup instances
      List<SchoolGroup> schoolGroups = data.map((item) => SchoolGroup.fromJson(item)).toList();

      dataService.saveSchoolGroups(schoolGroups);

      return schoolGroups;
    } else {
      throw Exception('Error loading school groups.');
    }
  }

  Future<void> submitResults(List<dynamic> results) async {
    final visitorId = dataService.getLoggedInUserId();
    final url = Uri.parse('$visitorUrl/$visitorId/submit-results/');
    
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(results),
    );

    if (response.statusCode != 201) {
      print(response.body);
      throw Exception('Failed to submit results for worksheet');
    }
  }
}