import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveUser(int visitorId, String username) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('visitor_id', visitorId);
  await prefs.setString('username', username);
}
