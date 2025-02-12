import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'data_service_visitors.dart';

class ApiService {
  final DataServiceVisitors dataService = DataServiceVisitors();
  final String baseUrl;
  final String areaUrl;

  ApiService()
      : baseUrl = dotenv.env['BASE_URL'] ?? '',
        areaUrl = '${dotenv.env['BASE_URL'] ?? ''}/areas/api';


  /// Fetches a list of all areas and their details from the API.
  Future<List<dynamic>> getAllAreas(List<int> schoolGroupIds) async {
    try {
      final response = await http
          .post(
            Uri.parse('$areaUrl/areas-all/'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({'school_groups': schoolGroupIds}),
          )
          .timeout(const Duration(seconds: 10)); 
      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        throw HttpException('Failed to load areas (Status: ${response.statusCode})');
      }
    } on SocketException {
      throw Exception('No internet connection or server is unreachable');
    }
  }

  Future<String> downloadAndSaveImage(String imageUrl, String fileName) async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/$fileName';

  if (File(filePath).existsSync()) {
    return filePath;
  }

  final response = await http.get(Uri.parse(imageUrl));
  print(response.statusCode);
  if (response.statusCode == 200) {
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  } else {
    throw Exception('Failed to download image');
  }
}

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
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load area details');
    }
  }

  Future<Map<String, dynamic>> getAreaStats(int areaId) async {
    final visitorId = dataService.getLoggedInUserId();

    final response = await http.get(Uri.parse('$areaUrl/$areaId/$visitorId/get-area-stats/'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load area stats');
    }
  }
}