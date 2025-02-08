import 'package:hive/hive.dart';
import 'api_service_areas.dart';

class DataService {

  Future<void> fetchAndCacheData(List<int> schoolGroupsIds) async {
    var apiService = ApiService();
    print('School groups: $schoolGroupsIds');
    var responseAreas = await apiService.getAllAreas(schoolGroupsIds);

    var box = Hive.box('appData');
    print('Areas: $responseAreas');
    box.put('areas', responseAreas);
    box.put('userSchoolGroups', schoolGroupsIds);
  }

  Future<void> saveUserId(int userId) async {
    var box = Hive.box('appData');
    box.put('userId', userId);
  }

  /*Future<void> syncPendingChanges() async {
    var box = Hive.box('appData');
    var pendingUpdates = box.get('pendingUpdates');

    if (pendingUpdates != null) {
      try {
        await http.post('https://api.example.com/sync', data: pendingUpdates);
        box.delete('pendingUpdates');
        print('Data synchronized.');
      } catch (e) {
        print('Error syncing data: $e');
      }
    }
  }*/
}