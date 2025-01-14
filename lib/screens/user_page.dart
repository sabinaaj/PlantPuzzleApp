import 'package:flutter/material.dart';
import 'package:plant_puzzle_app/screens/login_page.dart';
import 'package:plant_puzzle_app/utilities/user_storage.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

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
              icon: Icon(Icons.logout),
              onPressed: () {
                logoutUser();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            )
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Divider(
            height: 2.0,
            color: Colors.grey.shade300,
            thickness: 2.0,
          ),
        ),
      ),
    );
  }
}
