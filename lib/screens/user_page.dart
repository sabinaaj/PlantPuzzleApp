import 'package:flutter/material.dart';
import 'package:plant_puzzle_app/screens/welcome_page.dart';
import '../widgets/user_school_container.dart';
import '../widgets/user_overview_container.dart';
import '../utilities/user_storage.dart';
import '../services/api_service_visitors.dart';
import '../models/visitors.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final ApiService apiService = ApiService();
  late Future<Visitor> visitor;

  @override
  void initState() {
    super.initState();
    visitor = _fetchVisitorData();
  }

  /// Fetch the visitor data for the logged-in user
  Future<Visitor> _fetchVisitorData() async {
    final visitorId = await getLoggedInUserId();
    return await apiService.getVisitor(visitorId);
  }

  Future<void> _handleLogout(BuildContext context) async {
    final confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Odhlásit se'),
        content: const Text('Opravdu se chceš odhlásit?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Zrušit'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Odhlásit se'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      logoutUser();

      // Ensure the widget is still mounted before navigation
      if (!mounted) return;

      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil',
          style: TextStyle(fontSize: 20.0),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => _handleLogout(context),
            ),
          ),
        ],
      ),
      body: FutureBuilder<Visitor>(
        future: visitor,
        builder: (context, snapshot) {
          // Display loading indicator while waiting for data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Display error message if an error occurs
          else if (snapshot.hasError) {
            return Center(
                child:
                    Text('Stránku se nepodařilo načíst. Zkuste to znovu.'));
          }

          // Handle empty or missing data
          else if (!snapshot.hasData) {
            return const Center(child: Text('Uživatel nenalezen.'));
          }

          // Data successfully loaded
          final visitor = snapshot.data!;

          return SingleChildScrollView(
              child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserOverviewContainer(visitor: visitor),
                const SizedBox(height: 20.0),
                UserSchoolContainer(visitor: visitor),
              ],
            ),
          ));
        }
      ),
    );
  }
}
