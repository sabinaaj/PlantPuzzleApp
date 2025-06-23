import 'package:flutter/material.dart';
import '../screens/welcome_page.dart';
import '../widgets/users/user_school_container.dart';
import '../widgets/users/user_overview_container.dart';
import '../widgets/users/user_achievements_container.dart';
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
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0, bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserOverviewContainer(),
                    const SizedBox(height: 12.0),
                    UserAchievementsContainer(visitor: visitor),
                    const SizedBox(height: 20.0),
                    UserSchoolContainer(visitor: visitor),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}
