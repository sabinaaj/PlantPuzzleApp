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
    // Load data from Hive
    var box = Hive.box('appData');
    List<dynamic> areasData = box.get('areas', defaultValue: []);
    List<dynamic> worksheetResults = box.get('worksheetResults', defaultValue: []);

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

    // Get the list of worksheets in the area
    List<dynamic> worksheets = areaData['worksheets'] ?? [];
    int worksheetCount = worksheets.length;

    // Extract worksheet IDs
    List<int> worksheetIds = worksheets
        .map<int>((worksheet) => worksheet['id'] as int)
        .toList();

    // Group results by worksheet ID
    Map<int, List<Map<String, dynamic>>> groupedResults = {};

    for (var result in worksheetResults) {
      Map<String, dynamic> resultMap = Map<String, dynamic>.from(result);
      int worksheetId = resultMap['success_rate']['worksheet'];
      
      // If the result belongs to a worksheet in the area
      if (worksheetIds.contains(worksheetId)) {
        groupedResults.putIfAbsent(worksheetId, () => []).add(resultMap);
      }
    }

    // Get the latest results for each worksheet
    List<Map<String, dynamic>> latestResults = groupedResults.entries.map((entry) {
      // Sort by creation date (newest first)
      entry.value.sort((a, b) =>
          DateTime.parse(b['created_at']).compareTo(DateTime.parse(a['created_at'])));
      return entry.value.first;
    }).toList();

    int doneWorksheetCount = latestResults.length;

    // Calculate average success rate
    double averageSuccessRate = doneWorksheetCount > 0
        ? latestResults
                .map((result) => result['success_rate']['rate'])
                .reduce((a, b) => a + b) /
            latestResults.length
        : 0.0;

    // Return the calculated statistics
    return {
      'worksheet_count': worksheetCount,
      'done_worksheet_count': doneWorksheetCount,
      'average_success_rate': averageSuccessRate,
    };
  }

  List<Plant> getPlants(int areaId) {
    var box = Hive.box('appData');
    var areasData = box.get('areas', defaultValue: []);

    Map<dynamic, dynamic> areaData = areasData.firstWhere(
      (area) => area['id'] == areaId,
      orElse: () => {},
    );

    if (areaData.isEmpty) {
      return [];
    }

    List<dynamic> plants = areaData['plants'] ?? [];
    return plants.map<Plant>((json) => Plant.fromJson(json)).toList();
  }


}