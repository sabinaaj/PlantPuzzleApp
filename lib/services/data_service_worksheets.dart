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

  int? getWorksheetSuccessRate(int worksheetId) {
    var box = Hive.box('appData');
    final worksheetResults = box.get('worksheetResults', defaultValue: []);

    // Filter results by worksheetId
    final filteredResults = worksheetResults
        .where((result) => result['worksheetId'] == worksheetId)
        .toList();

    if (filteredResults.isEmpty) return null;

    // Sort results by createdAt
    filteredResults.sort((a, b) {
      final dateA = (a['createdAt'] is String) 
          ? DateTime.tryParse(a['createdAt']) ?? DateTime.fromMillisecondsSinceEpoch(0)
          : (a['createdAt'] is DateTime) 
              ? a['createdAt'] as DateTime 
              : DateTime.fromMillisecondsSinceEpoch(0);

      final dateB = (b['createdAt'] is String) 
          ? DateTime.tryParse(b['createdAt']) ?? DateTime.fromMillisecondsSinceEpoch(0)
          : (b['createdAt'] is DateTime) 
              ? b['createdAt'] as DateTime 
              : DateTime.fromMillisecondsSinceEpoch(0);

      return dateB.compareTo(dateA); // Seřazení sestupně (nejnovější první)
    });


    return filteredResults.first['successRate']['rate'];
}

  void saveWorksheetResult(int worksheetId, SuccessRate successRate, List<VisitorResponse> responses) async {
    var box = Hive.box('appData');
    final worksheetResults = box.get('worksheetResults') ?? [];

    worksheetResults.add({
      'worksheetId': worksheetId,
      'successRate': successRate.toJson(),
      'responses': responses.map((response) => response.toJson()).toList(),
      'createdAt': DateTime.now(),
      'isSynced': false
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