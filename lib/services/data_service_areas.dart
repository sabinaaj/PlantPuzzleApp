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

    Map<dynamic, dynamic> areaData = areasData.firstWhere(
      (area) => area['id'] == areaId,
      orElse: () => {},
    );

    if (areaData == {}) {
      return {
        'worksheet_count': 0,
        'done_worksheet_count': 0,
        'average_success_rate': 0.0,
      };
    }

    List<dynamic> worksheets = areaData['worksheets'] ?? [];

    int worksheetCount = worksheets.length;
    int doneWorksheetCount = worksheets.where((ws) => ws['success_rate'] != null).length;

    double averageSuccessRate = doneWorksheetCount > 0
        ? worksheets
            .where((ws) => ws['success_rate'] != null)
            .map((ws) => (ws['success_rate'] as num).toDouble())
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