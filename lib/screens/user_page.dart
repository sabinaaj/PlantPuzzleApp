import 'package:flutter/material.dart';
import 'package:plant_puzzle_app/screens/login_page.dart';
import 'package:plant_puzzle_app/utilities/user_storage.dart';
import '../services/api_service_visitors.dart';
import '../models/visitors.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final ApiService _apiService = ApiService();
  Visitor? visitor;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchVisitorData();
  }

  Future<void> _fetchVisitorData() async {
    try {
      final visitorId = await getLoggedInUserId();
      final fetchedVisitor = await _apiService.getVisitor(visitorId);
      setState(() {
        visitor = fetchedVisitor;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showErrorDialog('Chyba při načítání dat o uživateli. $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Chyba'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
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
              onPressed: () {
                logoutUser();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
          ),
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : visitor == null
              ? const Center(child: Text('Data o uživateli se nepodařilo načíst.'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Uživatelské jméno: ${visitor!.username}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Jméno: ${visitor!.firstName} ${visitor!.lastName}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      if (visitor!.schoolId != null)
                        Text(
                          'Škola ID: ${visitor!.schoolId}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditUserPage(visitor: visitor!),
                            ),
                          );
                        },
                        child: const Text('Upravit údaje'),
                      ),
                    ],
                  ),
                ),
    );
  }
}

class EditUserPage extends StatelessWidget {
  final Visitor visitor;

  const EditUserPage({super.key, required this.visitor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upravit profil')),
      body: Center(
        child: Text('Formulář pro úpravu uživatele (pracuje se na něm).'),
      ),
    );
  }
}
