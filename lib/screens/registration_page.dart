import 'package:flutter/material.dart';
import '../widgets/buttons/continue_button.dart';
import '../widgets/text_input.dart';
import '../services/api_service_visitors.dart';
import 'school_group_selection_page.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final ApiService _apiService = ApiService();

  String _selectedOption = 'Navštěvník botanického parku';
  bool _isLoading = false;

  void _validateAndContinue() async {
    final username = usernameController.text.trim();
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();

    if (username.isEmpty || firstName.isEmpty || lastName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vyplňte všechna pole!')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final isUsernameTaken = await _apiService.isUsernameTaken(username);

      if (isUsernameTaken) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Uživatelské jméno již existuje.')),
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }

      if (_selectedOption == 'Navštěvník botanického parku') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SchoolGroupSelectionPage(
            username: username,
            firstName: firstName,
            lastName: lastName,
          )),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SchoolGroupSelectionPage(
            username: username,
            firstName: firstName,
            lastName: lastName,
          )),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Došlo k chybě. Zkuste to znovu. $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
                text: _isLoading ? 'Načítám...' : 'Přejít na další krok',
                onPressed: _isLoading ? null : _validateAndContinue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
