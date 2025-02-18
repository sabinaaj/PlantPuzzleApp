import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';
import 'api_service_areas.dart';

class DataService {

  Future<void> fetchAndCacheDataNewUser(List<int> schoolGroupsIds) async {
    var apiService = ApiService();
    print('School groups: $schoolGroupsIds');
    var responseAreas = await apiService.getAllAreas(schoolGroupsIds);

    var box = Hive.box('appData');

    // save images
    for (var area in responseAreas) {
      // 1. save icon_url
      if (area['icon_url'] != null) {
        String imageUrl = area['icon_url'];
        String fileName = imageUrl.split('/').last;
        String localPath = await apiService.downloadAndSaveImage(imageUrl, fileName);
        area['icon_url'] = localPath;
        print("aaaaaaaaaaaaaaaaaaa");
      }

      // 2. save task images
      if (area['worksheets'] != null) {
        for (var worksheet in area['worksheets']) {
          if (worksheet['tasks'] != null) {
            for (var task in worksheet['tasks']) {
              if (task['images'] != null && task['images'].isNotEmpty) {
                for (var image in task['images']) {
                  String imageUrl = image['image_url'];
                  String fileName = imageUrl.split('/').last;
                  String localPath =
                      await apiService.downloadAndSaveImage(imageUrl, fileName);
                  image['image_url'] = localPath;
                }
              }
            }
          }
        }
      }
    }

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
      
      try{
        responseAreas = await apiService.getAllAreas(schoolGroupsIds);
      } catch (e) {
        return false;
      }
      

      // save images
      for (var area in responseAreas) {
        // 1. save icon_url
        if (area['icon_url'] != null) {
          String imageUrl = area['icon_url'];
          String fileName = imageUrl.split('/').last;
          String localPath = await apiService.downloadAndSaveImage(imageUrl, fileName);
          area['icon_url'] = localPath;
        }

        // 2. Save task images
        if (area['worksheets'] != null) {
          for (var worksheet in area['worksheets']) {
            if (worksheet['tasks'] != null) {
              for (var task in worksheet['tasks']) {
                if (task['images'] != null && task['images'].isNotEmpty) {
                  for (var image in task['images']) {
                    String imageUrl = image['image_url'];
                    String fileName = imageUrl.split('/').last;
                    String localPath =
                        await apiService.downloadAndSaveImage(imageUrl, fileName);
                    image['image_url'] = localPath;
                  }
                }
              }
            }
          }
        }
      }

      box.put('areas', responseAreas);

      return true;
      
    } else {
      return false;
    }
  }

 
}