import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../utilities/user_storage.dart';

class ApiService {
  final String baseUrl;
  final String areaUrl;

  ApiService()
      : baseUrl = dotenv.env['BASE_URL'] ?? '',
        areaUrl = '${dotenv.env['BASE_URL'] ?? ''}/areas/api';

  /// Fetches the list of areas from the API.
  Future<List<dynamic>> getAreas() async {
    final response = await http.get(Uri.parse('$areaUrl/areas/'));

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load areas');
    }
  }

  /// Fetches details of a specific area by its ID from the API.
  Future<Map<String, dynamic>> getAreaDetails(int areaId) async {
    final response = await http.get(Uri.parse('$areaUrl/areas/$areaId/'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load area details');
    }
  }

  Future<Map<String, dynamic>> getAreaStats(int areaId) async {
    final visitorId = await getLoggedInUserId();

    final response = await http.get(Uri.parse('$areaUrl/$areaId/$visitorId/get-area-stats/'));
    print(response.body);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load area stats');
    }
  }
}