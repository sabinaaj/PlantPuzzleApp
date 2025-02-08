import 'package:hive/hive.dart';

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

}