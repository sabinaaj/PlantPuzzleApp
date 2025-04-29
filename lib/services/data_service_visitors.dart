import 'package:hive/hive.dart';
import 'package:plant_puzzle_app/models/visitors.dart';

class DataServiceVisitors {

  /// Saves the user ID of the logged-in visitor in local storage.
  void saveUserId(int userId) {
    var box = Hive.box('appData');
    box.put('userId', userId);
  }

  /// Retrieves the visitor ID of the logged-in user from local storage.
  int getLoggedInUserId() {
    var box = Hive.box('appData');
    return box.get('userId');
  }

  Visitor getLoggedInUser() {
    var box = Hive.box('appData');
    final userId = box.get('userId');
    final schoolsGroupIds = box.get('userSchoolGroups');

    return Visitor(
      id: userId,
      schoolGroupIds: schoolsGroupIds
    );
  }

  /// Logs out the current user by removing the saved visitor ID from local storage.
  void logoutUser() {
    var box = Hive.box('appData');
    box.delete('userId');
  }

  /// Checks if the user is logged in by checking if the visitor ID is stored in local storage.
  bool isUserLoggedIn() {
    var box = Hive.box('appData');
    return box.containsKey('userId');
  }

  void saveUserSchoolGroups(List<Object> schoolGroupsIds) {
    var box = Hive.box('appData');
    box.put('userSchoolGroups', schoolGroupsIds);
  }

  void saveSchoolGroups(List<SchoolGroup> schoolGroups) {
    var box = Hive.box('appData');
    var jsonList = schoolGroups.map((group) => group.toJson()).toList();
    box.put('SchoolGroups', jsonList);
  }

  List<SchoolGroup> getSchoolGroups() {
    var box = Hive.box('appData');
    var jsonList = box.get('SchoolGroups', defaultValue: []);

    final schoolGroups = (jsonList as List)
        .map((json) => SchoolGroup.fromJson(Map<String, dynamic>.from(json as Map)))
        .toList();

    return schoolGroups;
  }

  void saveAchievements(List<Achievement> achievements) {
    var box = Hive.box('appData');
    var jsonList = achievements.map((achievement) => achievement.toJson()).toList();
    box.put('achievements', jsonList);
  }

  List<Achievement> getAchievements() {
    var box = Hive.box('appData');
    final jsonList = box.get('achievements', defaultValue: []);

    final achievements = (jsonList as List)
        .map((json) => Achievement.fromJson(Map<String, dynamic>.from(json as Map)))
        .toList();

    return achievements;
  }

  Map<String, dynamic> getVisitorStats() {
    var box = Hive.box('appData');
    List<dynamic> areasData = box.get('areas', defaultValue: []);
    List<dynamic> worksheetResults = box.get('worksheetResults', defaultValue: []);
    List<dynamic> achievements = box.get('achievements', defaultValue: []);


    if (areasData.isEmpty) {
      return {
        'worksheet_count': 0,
        'done_worksheet_count': 0,
        'average_success_rate': 0.0,
        'achievements_count': 0,
        'achievements_unlocked': 0
      };
    }

    // Get all worksheets
    List<dynamic> worksheets = areasData
      .expand((area) => area['worksheets'] ?? [])
      .toList();

    int worksheetCount = worksheets.length;

    // Group results by worksheet ID
    Map<int, List<Map<String, dynamic>>> groupedResults = {};

    for (var result in worksheetResults) {
      Map<String, dynamic> resultMap = Map<String, dynamic>.from(result);
      if (resultMap.isNotEmpty){
        int worksheetId = resultMap['success_rate']['worksheet'];

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

    int achievementsCount = achievements.length;
    int achievementsUnlocked = achievements.where((achievement) => achievement['unlocked']).length;

    // Return the calculated statistics
    return {
      'worksheet_count': worksheetCount,
      'done_worksheet_count': doneWorksheetCount,
      'average_success_rate': averageSuccessRate,
      'achievements_count': achievementsCount,
      'achievements_unlocked': achievementsUnlocked
    };

  }


  bool isAnyAreaDone() {
    var box = Hive.box('appData');
    List<dynamic> areasData = box.get('areas', defaultValue: []);
    List<dynamic> worksheetResults = box.get('worksheetResults', defaultValue: []);

    if (areasData.isEmpty) {
      return false;
    }

    // Group results by worksheet ID
    Set<dynamic> completedWorksheets = worksheetResults
        .map((result) => result['success_rate']['worksheet'])
        .toSet();

    print(areasData);

    // Check if any area has all worksheets completed
    for (var area in areasData) {
      List<dynamic> worksheets = area['worksheets'] ?? [];
      if (worksheets.isNotEmpty &&
          worksheets.every((worksheet) => completedWorksheets.contains(worksheet['id']))) {
        return true; // At least one area has all worksheets completed
      }
    }

    return false;
  }

  bool areAllWorksheetsDone() {
    var box = Hive.box('appData');
    List<dynamic> areasData = box.get('areas', defaultValue: []);
    List<dynamic> worksheetResults = box.get('worksheetResults', defaultValue: []);

    if (areasData.isEmpty) {
      return false;
    }

    Set<dynamic> allWorksheets = areasData
        .expand((area) => area['worksheets'] ?? [])
        .map((worksheet) => worksheet['id'])
        .toSet();

    Set<dynamic> completedWorksheets = worksheetResults
        .map((result) => result['success_rate']['worksheet'])
        .toSet();

    return allWorksheets.every((id) => completedWorksheets.contains(id));
  }

  bool isHalfOfWorksheetsDone() {
    var box = Hive.box('appData');
    List<dynamic> areasData = box.get('areas', defaultValue: []);
    List<dynamic> worksheetResults = box.get('worksheetResults', defaultValue: []);

    if (areasData.isEmpty) {
      return false;
    }

    Set<dynamic> allWorksheets = areasData
        .expand((area) => area['worksheets'] ?? [])
        .map((worksheet) => worksheet['id'])
        .toSet();

    Set<dynamic> completedWorksheets = worksheetResults
        .map((result) => result['success_rate']['worksheet'])
        .toSet();

    return completedWorksheets.length >= (allWorksheets.length / 2);
  }

  double getSuccessRate() {
    var box = Hive.box('appData');
    List<dynamic> worksheetResults = box.get('worksheetResults', defaultValue: []);

    if (worksheetResults.isEmpty) {
      return 0.0;
    }

    // Group results by worksheet ID
    Map<int, List<Map<String, dynamic>>> groupedResults = {};

    for (var result in worksheetResults) {
      Map<String, dynamic> resultMap = Map<String, dynamic>.from(result);
      int worksheetId = resultMap['success_rate']['worksheet'];
      
      groupedResults.putIfAbsent(worksheetId, () => []).add(resultMap);
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

    return averageSuccessRate;
  }
}