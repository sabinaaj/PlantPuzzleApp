import 'package:hive/hive.dart';
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


}