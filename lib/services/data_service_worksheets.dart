import 'package:hive/hive.dart';
import 'package:plant_puzzle_app/models/visitors.dart';
import 'package:plant_puzzle_app/models/worksheet.dart';

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

  void saveWorksheetResult(int worksheetId, SuccessRate successRate, List<VisitorResponse> responses) async {
    var box = Hive.box('appData');
    
    final worksheetResults = box.get('worksheetResults') ?? [];

    worksheetResults.add({
      'worksheetId': worksheetId,
      'successRate': successRate.toJson(),
      'responses': responses.map((response) => response.toJson()).toList(),
      'is_synced': false
    });

    box.put('worksheetResults', worksheetResults);

  }

  Future<void> syncWorksheetResults() async {
    var box = Hive.box('appData');
    final worksheetResults = box.get('worksheetResults') ?? [];

    for (var result in worksheetResults) {
      if (result['is_synced'] == false) {
        // Send result to server
        result['is_synced'] = true;
      }
    }

    box.put('worksheetResults', worksheetResults);
  }
}