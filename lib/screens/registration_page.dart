import 'package:flutter/material.dart';
import 'school_group_selection_page.dart';
import '../widgets/buttons/continue_button.dart';
import '../widgets/text_input.dart';
import '../widgets/border_container.dart';
import '../widgets/error_message.dart';
import '../widgets/radio_option_row.dart';
import '../services/api_service_visitors.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  // Controllers for user input fields
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final ApiService apiService = ApiService();

  String selectedOption = 'Navštěvník botanického parku';

  // Variables for error handling
  String errorMessage = '';
  bool errorVisibility = false;

  // Function to validate input and navigate to the next page
  void _validateAndContinue() async {
    final username = usernameController.text.trim();
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();

    // Check if all fields are filled
    if (username.isEmpty || firstName.isEmpty || lastName.isEmpty) {
      setState(() {
        errorMessage = 'Vyplň všechna pole.'; // Display an error message
        errorVisibility = true;
      });
      return;
    }

    try {
      // Check if the username is already taken
      final isUsernameTaken = await apiService.isUsernameTaken(username);

      if (isUsernameTaken) {
        setState(() {
          errorMessage = 'Vyber jiné uživatelské jméno.'; // Error for duplicate username
          errorVisibility = true;
        });
        return;
      }

      // Ensure the widget is still mounted before navigating
      if (!mounted) return;

     if (selectedOption == 'Navštěvník botanického parku') {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SchoolGroupSelectionPage(
                    username: username,
                    firstName: firstName,
                    lastName: lastName,
                  )),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SchoolGroupSelectionPage(
                    username: username,
                    firstName: firstName,
                    lastName: lastName,
                  )),
        );
      }
    } catch (e) {
      // Handle any unexpected errors
      setState(() {
        errorMessage = 'Došlo k chybě. Zkus to znovu.'; // Generic error message
        errorVisibility = true;
      });
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
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
              // Page title
              Text(
                'Registrace',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 10.0),

              // Display error message if any
              ErrorMessage(message: errorMessage, visibility: errorVisibility),

              const SizedBox(height: 5.0),

              // Input for username
              TextInput(
                hintText: 'Uživatelské jméno',
                textController: usernameController,
              ),

              const SizedBox(height: 10.0),

              // Input for first name
              TextInput(
                hintText: 'Křestní jméno',
                textController: firstNameController,
              ),

              const SizedBox(height: 10.0),

              // Input for last name
              TextInput(
                hintText: 'Příjmení',
                textController: lastNameController,
              ),

              const SizedBox(height: 10.0),

              // Container for radio button options
              BorderContainer(
                padding: 10.0,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      'Jsem', 
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10.0),

                  // Option: Botanical park visitor
                  OptionRow(
                    label: 'Navštěvník botanického parku',
                    value: 'Navštěvník botanického parku',
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value;
                      });
                    },
                  ),

                  // Option: School excursion visitor
                  OptionRow(
                    label: 'Na školní exkurzi',
                    value: 'Na školní exkurzi',
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20.0),

              // Continue button
              ContinueButton(
                height: 55,
                text: 'Přejít na další krok',
                onPressed: _validateAndContinue, // Trigger validation and navigation
              ),
            ],
          ),
        ),
      ),
    );
  }
}
