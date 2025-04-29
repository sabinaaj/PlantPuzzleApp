import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/visitors.dart';
import 'data_service_visitors.dart';
import 'data_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ApiService {
  final String baseUrl;
  final String visitorUrl;
  final DataServiceVisitors dataServiceVisitors = DataServiceVisitors();
  final DataService dataService = DataService();

  ApiService()
      : baseUrl = dotenv.env['BASE_URL'] ?? '',
        visitorUrl = '${dotenv.env['BASE_URL'] ?? ''}/visitors/api';

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
      dataServiceVisitors.saveUserId(data['visitor_id']);
    } else {
      throw Exception('Registration failed.');
    }
  }

  Future<bool> updateVisitor(Visitor visitor) async {
    try {
      final url = Uri.parse('$visitorUrl/${visitor.id}/update/');
      await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(visitor.toJson()),
      );
      print(visitor.schoolGroupIds);
      dataServiceVisitors.saveUserSchoolGroups(visitor.schoolGroupIds ?? []);
      await dataService.fetchAndCacheData();

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Retrieves a list of school groups from the API.
  Future<List<SchoolGroup>> getSchoolGroups() async {
    final response = await http.get(Uri.parse('$visitorUrl/school-groups/'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

      List<SchoolGroup> schoolGroups =
          data.map((item) => SchoolGroup.fromJson(item)).toList();

      dataServiceVisitors.saveSchoolGroups(schoolGroups);

      return schoolGroups;
    } else {
      throw Exception('Error loading school groups.');
    }
  }

  Future<bool> submitResults(List<dynamic> results) async {
    try {
      final visitorId = dataServiceVisitors.getLoggedInUserId();
      final url = Uri.parse('$visitorUrl/$visitorId/submit-results/');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(results),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true; // Úspěšné odeslání
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<int?> getBetterThan() async {
    final visitorId = dataServiceVisitors.getLoggedInUserId();
    final url = Uri.parse('$visitorUrl/$visitorId/better-than/');

    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      try {
        final response = await http.get(url);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          return data['better_than'].toInt();
        } else {
          return null;
        }
      }
      catch (e) {
        return null;
      }
    }
    return null;
  }
}
