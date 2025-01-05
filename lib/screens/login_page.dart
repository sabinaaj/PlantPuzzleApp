import 'package:flutter/material.dart';
import '../widgets/buttons/continue_button.dart';
import '../widgets/text_input.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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

              TextInput(hintText: 'Uživatelské jméno'),
               
              ContinueButton(
                height: 55,
                text: 'Přihlásit se',
                onPressed: () => (),),
              
              TextButton(
                onPressed: () {
                  print('Přesměrování na registraci');
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
