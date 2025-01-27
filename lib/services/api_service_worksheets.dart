import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;
  final String worksheetUrl;

  ApiService()
      : baseUrl = dotenv.env['BASE_URL'] ?? '',
        worksheetUrl = '${dotenv.env['BASE_URL'] ?? ''}/worksheets/api';

  /// Fetches the list of worksheets associated with a specific area by its ID.
  Future<List<dynamic>> getWorksheetsByArea(int areaId) async {
    final response =
        await http.get(Uri.parse('$worksheetUrl/$areaId/worksheets/'));

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load worksheets for area $areaId');
    }
  }

  /// Fetches details of a specific worksheet by its ID from the API.
  Future<Map<String, dynamic>> getWorksheet(int worksheetId) async {
    final response =
        await http.get(Uri.parse('$worksheetUrl/$worksheetId/worksheet/'));

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load worksheet $worksheetId');
    }
  }
}
