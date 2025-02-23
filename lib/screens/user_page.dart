import 'package:flutter/material.dart';
import 'package:plant_puzzle_app/screens/welcome_page.dart';
import '../widgets/user_school_container.dart';
import '../widgets/user_overview_container.dart';
import '../services/data_service_visitors.dart';

class UserPage extends StatelessWidget {
  UserPage({super.key});

  final DataServiceVisitors dataService = DataServiceVisitors();

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
      dataService.logoutUser();

      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final visitor = dataService.getLoggedInUser();

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
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserOverviewContainer(visitor: visitor),
              const SizedBox(height: 20.0),
              UserSchoolContainer(visitor: visitor),
            ],
          ),
        )
      )
    );
  }
}
