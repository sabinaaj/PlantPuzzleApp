import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://192.168.68.111:8001/areas/api"; 

  Future<List<dynamic>> getAreas() async {
    final response = await http.get(Uri.parse('$baseUrl/areas/'));
    
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load areas');
    }
  }

  Future<Map<String, dynamic>> getAreaDetails(int areaId) async {
    final response = await http.get(Uri.parse('$baseUrl/areas/$areaId/'));
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load area details');
    }
  }
}
