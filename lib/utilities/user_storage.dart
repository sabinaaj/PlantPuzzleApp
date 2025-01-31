import 'package:shared_preferences/shared_preferences.dart';

/// Saves the user ID of the logged-in visitor in local storage.
Future<void> saveUserId(int visitorId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('visitor_id', visitorId);
}

/// Checks if the user is logged in by checking if the visitor ID is stored in local storage.
Future<bool> isUserLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.containsKey('visitor_id');
}

/// Logs out the current user by removing the saved visitor ID from local storage.
Future<void> logoutUser() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('visitor_id');
}

/// Retrieves the visitor ID of the logged-in user from local storage.
Future<int> getLoggedInUserId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('visitor_id') ?? 0;
}
