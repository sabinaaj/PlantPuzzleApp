import 'package:flutter/material.dart';
import '../widgets/buttons/continue_button.dart';
import '../widgets/text_input.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  String _selectedOption = 'Navštěvník botanického parku';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'REGISTRACE',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20.0),

              TextInput(
                hintText: 'Uživatelské jméno',
                textController: usernameController
              ),

              const SizedBox(height: 10.0),

              TextInput(
                hintText: 'Křestní jméno',
                textController: firstNameController
              ),

              const SizedBox(height: 10.0),

              TextInput(
                hintText: 'Příjmení',
                textController: lastNameController
              ),

              const SizedBox(height: 10.0),

              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                 border: Border.all(color: Colors.grey.shade300, width: 2.0),
                 borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jsem',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade800
                      ),
                    ),

                    const SizedBox(height: 10.0),

                    Row(
                      children: [
                      Radio<String>(
                      groupValue: _selectedOption,
                      value: 'Navštěvník botanického parku',
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                      },
                    ),

                    Text('Navštěvník botanického parku'),
                    ]),

                    Row(
                      children: [
                      Radio<String>(
                      groupValue: _selectedOption,
                      value: 'Na školní exkurzi',
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                      },
                    ),

                    Text('Na školní exkurzi'),
                    ])

                  ],
                ),
              ),

              const SizedBox(height: 20.0),

              ContinueButton(
                height: 55,
                text: 'Registrovat se',
                onPressed: () {
                  print('Vybraný typ: $_selectedOption');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
