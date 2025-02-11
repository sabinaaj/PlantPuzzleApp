import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/area_list_page.dart';
import 'screens/welcome_page.dart';
import 'services/data_service_visitors.dart';
import 'utilities/lifecycle_manager.dart';
import 'services/sync_service.dart';
import 'themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();
  await Hive.openBox('appData');
  SyncService().startSync();

  runApp(AppLifecycleManager(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: lightTheme,
      themeMode: ThemeMode.light,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final DataServiceVisitors dataService = DataServiceVisitors();


  @override
  Widget build(BuildContext context) {

    if (dataService.isUserLoggedIn()){
      return AreaListPage();
    }
    else {
      return WelcomePage();
    }
  }
}