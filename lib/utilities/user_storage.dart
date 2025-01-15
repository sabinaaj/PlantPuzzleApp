import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveUser(int visitorId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('visitor_id', visitorId);
}

Future<bool> isUserLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.containsKey('visitor_id');
}

Future<void> logoutUser() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('visitor_id');
}
