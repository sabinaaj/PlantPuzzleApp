import 'package:hive/hive.dart';
import '../models/visitors.dart';
import '../models/worksheet.dart';
import 'api_service_visitors.dart';


class DataServiceWorksheets {

  List<WorksheetSummary> getWorksheets(int areaId) {
    var box = Hive.box('appData');
    var areasData = box.get('areas', defaultValue: []);

    Map<dynamic, dynamic> areaData = areasData.firstWhere(
      (area) => area['id'] == areaId,
      orElse: () => {},
    );

    if (areaData == {}) {
      return [];
    }

    List<dynamic> worksheets = areaData['worksheets'] ?? [];
    return worksheets.map<WorksheetSummary>((json) => WorksheetSummary.fromJson(json)).toList();
  }

  Worksheet getWorksheet(int worksheetId) {
    var box = Hive.box('appData');
    var areasData = box.get('areas', defaultValue: []);

    List<Map<String, dynamic>> areas = List<Map<String, dynamic>>.from(
      areasData.map((e) => Map<String, dynamic>.from(e))
    );

    for (var area in areas) {
      var worksheets = area['worksheets'] ?? [];

      for (var worksheetData in worksheets) {
        if (worksheetData['id'] == worksheetId) {
          return Worksheet.fromJson(Map<String, dynamic>.from(worksheetData));
        }
      }
    }

    return Worksheet.empty();
  }

  int? getWorksheetSuccessRate(int worksheetId) {
    var box = Hive.box('appData');
    final worksheetResults = box.get('worksheetResults', defaultValue: []);

    // Filter results by worksheetId
    final filteredResults = worksheetResults.where((result) {
      return result['success_rate']['worksheet'] == worksheetId;
    }).toList();

    if (filteredResults.isEmpty) return null;

    // Sort results by createdAt
    filteredResults.sort((a, b) => DateTime.parse(b['created_at'])
    .compareTo(DateTime.parse(a['created_at'])));

    // Get the latest success rate
    int? latestRate = filteredResults.isNotEmpty
    ? filteredResults.first['success_rate']['rate']
    : null;


    return latestRate;
  }

  void saveWorksheetResult(int worksheetId, SuccessRate successRate, List<VisitorResponse> responses) async {
    var box = Hive.box('appData');
    final worksheetResults = box.get('worksheetResults') ?? [];

    worksheetResults.add({
      'success_rate': successRate.toJson(),
      'responses': responses.map((response) => response.toJson()).toList(),
      'created_at': DateTime.now().toIso8601String(),
      'is_synced': false
    });

    box.put('worksheetResults', worksheetResults);

  }

  Future<void> syncWorksheetResults() async {
    var box = Hive.box('appData');
    final worksheetResults = box.get('worksheetResults') ?? [];

    final unsyncedResults = worksheetResults.where((result) => result['is_synced'] == false).toList();
    final ApiService apiService = ApiService();
    await apiService.submitResults(unsyncedResults);

    for (var result in unsyncedResults) {
      result['is_synced'] = true;
    }

    box.put('worksheetResults', worksheetResults);
  }
}