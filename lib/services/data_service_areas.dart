import 'package:hive/hive.dart';
import '../models/area.dart';

class DataServiceAreas {


  List<Area> getAreas() {
    var box = Hive.box('appData');
    var areasJson = box.get('areas', defaultValue: []);

    if (areasJson is List) {
      return areasJson
        .map((area) => Area.fromJson(Map<String, dynamic>.from(area)))
        .toList();
    } else {
      return [];
    }
  }

  Map<String, dynamic> getAreaStats(int areaId) {
    var box = Hive.box('appData');
    var areasData = box.get('areas', defaultValue: []);
    var worksheetResults = box.get('worksheetResults', defaultValue: []);

    Map<dynamic, dynamic> areaData = areasData.firstWhere(
      (area) => area['id'] == areaId,
      orElse: () => {},
    );

    if (areaData.isEmpty) {
      return {
        'worksheet_count': 0,
        'done_worksheet_count': 0,
        'average_success_rate': 0.0,
      };
    }

    List<dynamic> worksheets = areaData['worksheets'] ?? [];
    int worksheetCount = worksheets.length;

    // Najít výsledky odpovídající worksheets v této oblasti
    Map<int, dynamic> latestResults = {};

    for (var result in worksheetResults) {
      int worksheetId = result['worksheetId'];
      if (worksheets.any((ws) => ws['id'] == worksheetId)) {
        DateTime resultDate = (result['createdAt'] is String && result['createdAt'] != null) 
          ? DateTime.tryParse(result['createdAt'] as String) ?? DateTime.fromMillisecondsSinceEpoch(0)
          : DateTime.fromMillisecondsSinceEpoch(0);

        if (!latestResults.containsKey(worksheetId) || 
          resultDate.isAfter(
            (latestResults[worksheetId]?['createdAt'] is String) 
              ? DateTime.tryParse(latestResults[worksheetId]['createdAt']) ?? DateTime.fromMillisecondsSinceEpoch(0)
              : DateTime.fromMillisecondsSinceEpoch(0)
          )
        ) {
          latestResults[worksheetId] = result;
        }
      }
    }

    int doneWorksheetCount = latestResults.length;

    double averageSuccessRate = doneWorksheetCount > 0
        ? latestResults.values
            .map((result) => (result['successRate']['rate'] as num).toDouble())
            .reduce((a, b) => a + b) /
            doneWorksheetCount
        : 0.0;

    return {
      'worksheet_count': worksheetCount,
      'done_worksheet_count': doneWorksheetCount,
      'average_success_rate': averageSuccessRate,
    };
  }

}