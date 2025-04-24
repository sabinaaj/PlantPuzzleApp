import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'api_service_areas.dart';
import 'dart:io';

class DataService {
  final ApiService _apiService;

  DataService() : _apiService = ApiService();

  Future<void> fetchAndCacheDataNewUser(List<int> schoolGroupsIds) async {
    var apiService = ApiService();
    var responseAreas = await apiService.getAllAreas(schoolGroupsIds);

    var box = Hive.box('appData');

    // save images
    for (var area in responseAreas) {
      area = await _saveImages(area);
    }

    box.put('areas', responseAreas);
    box.put('userSchoolGroups', schoolGroupsIds);
  }

  Future<bool> fetchAndCacheData() async {
    var apiService = ApiService();
    var box = Hive.box('appData');
    var schoolGroupsIds = box.get('userSchoolGroups');
    var responseAreas = box.get('areas');

    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      try {
        responseAreas = await apiService.getAllAreas(schoolGroupsIds);
      } catch (e) {
        return false;
      }

      // save images
      for (var area in responseAreas) {
        await _saveImages(area);
      }

      box.put('areas', responseAreas);

      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> _saveImages(dynamic area) async {
    final Set<String> usedImagePaths = {};

    print("here");

    // 1. save icon_url
    if (area['icon_url'] != null) {
      final imageUrl = area['icon_url'];
      final fileName = imageUrl.split('/').last;
      print(imageUrl);
      final localPath = await _apiService.downloadAndSaveImage(imageUrl, fileName);
      area['icon_url'] = localPath;
      usedImagePaths.add(localPath);
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
                String localPath = await _apiService.downloadAndSaveImage(imageUrl, fileName);
                image['image_url'] = localPath;
                usedImagePaths.add(localPath);
              }
            }
          }
        }
      }
    }

    // 3. save plant images
    if (area['plants'] != null) {
      for (var plant in area['plants']) {
        if (plant['images'] != null && plant['images'].isNotEmpty) {
          for (var image in plant['images']) {
            String imageUrl = image['image_url'];
            String fileName = imageUrl.split('/').last;
            String localPath = await _apiService.downloadAndSaveImage(imageUrl, fileName);
            image['image_url'] = localPath;
            usedImagePaths.add(localPath);
          }
        }
      }
    }

    //await _cleanupUnusedImages(usedImagePaths);

    return area;
  }

  /*Future<void> _cleanupUnusedImages(Set<String> usedPaths) async {
    final directory = await getLibraryDirectory();
    final files = Directory(directory.path).listSync();

    for (var file in files) {
      if (!usedPaths.contains(file.path)) {
        try {
          await file.delete();
        } catch (e) {}
      }
    }
  }*/
}
