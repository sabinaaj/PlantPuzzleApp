import 'package:flutter/material.dart';
import 'area_list_page.dart';
import 'registration_page.dart';
import '../widgets/buttons/continue_button.dart';
import '../widgets/error_message.dart';
import '../widgets/text_input.dart';
import '../services/api_service_visitors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controller to manage user input for the username field
  final TextEditingController usernameController = TextEditingController();
  final ApiService apiService = ApiService();

  // Variables for error handling
  String errorMessage = '';
  bool errorVisibility = false;

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  // Handles the login logic
  Future<void> _handleLogin(BuildContext context) async {
    final username = usernameController.text.trim();

    if (username.isEmpty) {
      // Show error if the username field is empty
      setState(() {
        errorMessage = 'Zadej uživatelské jméno.';
        errorVisibility = true;
      });
      return;
    }

    try {
      await apiService.loginUser(username);

      // Check if the widget is still mounted
      if (!mounted) return; 
      
      // Navigate to the AreaListPage on successful login
      Navigator.pushAndRemoveUntil(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const AreaListPage()),
        (route) => false,
      );
    } catch (e) {
      setState(() {
        errorMessage = 'Přihlášení se nezdařilo. Zkontroluj zadané údaje.';
        errorVisibility = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Main layout for the login page
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo image
              Image.asset(
                'assets/images/logo.png',
                height: 125,
                width: 125,
              ),

              const SizedBox(height: 8.0),

              // App title
              const Text(
                'PlantPuzzle',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 20.0),

              // Error message
              ErrorMessage(
                message: errorMessage,
                visibility: errorVisibility
              ),
              
              const SizedBox(height: 5.0),

              // Username input field
              TextInput(
                hintText: 'Uživatelské jméno',
                textController: usernameController,
                icon: const Icon(Icons.person_outlined),
              ),

              const SizedBox(height: 10.0),

              // Login button
              ContinueButton(
                height: 55,
                text: 'Přihlásit se', 
                onPressed: () => _handleLogin(context),
                vPadding: 0.0,
              ),

              // Link to the registration page
              TextButton(
                onPressed: () {
                  // Navigate to the RegistrationPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistrationPage(),
                    ),
                  );
                },
                child: Text(
                  'Jsi tu poprvé? Zaregistruj se', 
                  style: TextStyle(
                    color: Colors.grey.shade800, 
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
