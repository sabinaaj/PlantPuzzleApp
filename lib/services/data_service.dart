import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';
import 'api_service_areas.dart';

class DataService {

  Future<void> fetchAndCacheDataNewUser(List<int> schoolGroupsIds) async {
    var apiService = ApiService();
    print('School groups: $schoolGroupsIds');
    var responseAreas = await apiService.getAllAreas(schoolGroupsIds);

    var box = Hive.box('appData');
    print('Areas: $responseAreas');
    box.put('areas', responseAreas);
    box.put('userSchoolGroups', schoolGroupsIds);
  }

  Future<bool> fetchAndCacheData() async {
    var apiService = ApiService();
    var box = Hive.box('appData');
    var schoolGroupsIds = box.get('userSchoolGroups');
    var responseAreas = box.get('areas');

    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult.contains(ConnectivityResult.wifi)) {
      responseAreas = await apiService.getAllAreas(schoolGroupsIds);

      print('Areas: $responseAreas');
      box.put('areas', responseAreas);

      return true;
      
    } else {
      return false;
    }
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