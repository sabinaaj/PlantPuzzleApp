import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://192.168.68.111:8001/worksheets/api"; 

  Future<List<dynamic>> getWorksheetsByArea(int areaId) async {
    final response = await http.get(Uri.parse('$baseUrl/$areaId/worksheets/'));
    
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load worksheets for area $areaId');
    }
  }

  Future<Map<String, dynamic>> getWorksheet(int worksheetId) async {
    final response = await http.get(Uri.parse('$baseUrl/$worksheetId/worksheet/'));
      
      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        throw Exception('Failed to load worksheet $worksheetId');
      }
  }

}
