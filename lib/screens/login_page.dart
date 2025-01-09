import 'package:flutter/material.dart';
import '../widgets/buttons/continue_button.dart';
import '../widgets/text_input.dart';
import '../services/api_service_visitors.dart';
import 'area_list_page.dart';
import 'registration_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 125,
                width: 125,
              ),
              Text(
                'PlantPuzzle',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 40.0),

              TextInput(
                hintText: 'Uživatelské jméno',
                textController: usernameController,
              ),

              ContinueButton(
                height: 55,
                text: 'Přihlásit se',
                onPressed: () async {
                  String username = usernameController.text.trim();

                  if (username.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Zadejte uživatelské jméno!')),
                    );
                    return;
                  }

                  try {
                    await _apiService.loginUser(username);
                    // Přesměrování při úspěšném přihlášení
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const AreaListPage(),
                      ),
                      (route) => false,
                    );
                  } catch (e) {
                    // Zobrazení varování při selhání
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Přihlášení se nezdařilo. Zkontrolujte uživatelské jméno.')),
                    );
                  }
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistrationPage(),
                    ),
                  );
                },
                child: Text('Nemáš účet? Zaregistruj se'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
