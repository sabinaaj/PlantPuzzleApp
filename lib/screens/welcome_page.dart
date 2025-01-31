import 'package:flutter/material.dart';
import '../widgets/buttons/continue_button.dart';
import '../widgets/school_group_selection.dart';
import '../widgets/error_message.dart';
import '../services/api_service_visitors.dart';
import '../models/visitors.dart';
import 'area_list_page.dart';

class WelcomePage extends StatefulWidget {

  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final ApiService apiService = ApiService();
  late Future<List<dynamic>> schoolGroups;
  List<int> selectedGroups = [];

  // Variables for error handling
  String errorMessage = '';
  bool errorVisibility = false;

  @override
  void initState() {
    super.initState();
    schoolGroups = _fetchSchoolGroups(); 
  }

  /// Fetch school groups from the API
  Future<List<dynamic>> _fetchSchoolGroups() async {
    return await apiService.getSchoolGroups();
  }

  /// Register the user with selected school groups
  void _save() async {
    // Check if no groups are selected
    if (selectedGroups.isEmpty) {
      setState(() {
        errorMessage = 'Vyber si alespoň jednu skupinu.';
        errorVisibility = true;
      });
      return;
    }

    try {
      // Create a Visitor object
      final visitor = Visitor(
        schoolGroupIds: selectedGroups,
      );

      await apiService.saveUser(visitor);

      // Ensure the widget is still mounted before navigation
      if (!mounted) return;

      // Navigate to the AreaListPage and remove previous routes
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => AreaListPage()),
        (route) => false,
      );
    } catch (e) {
      setState(() {
        errorMessage = 'Registrace se nezdařila.';
        errorVisibility = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: schoolGroups,
      builder: (context, snapshot) {
        // Display loading indicator while waiting for data
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Display error message if an error occurs
        else if (snapshot.hasError) {
          return Center(
                child: Text('Stránku se nepodařilo načíst. Zkuste to znovu.'));
        }

        // Handle empty or missing data
        else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Stránka nenalezena.'));
        }

        // Data successfully loaded
        final schoolGroups = snapshot.data!;

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

              const SizedBox(height: 6.0),

                // Logo image
              Image.asset(
                'assets/images/logo.png',
                height: 125,
                width: 125,
              ),

              const SizedBox(height: 6.0),

              // App title
              const Text(
                'Vítej v PlantPuzzle',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),

                // Greeting text
                const Text(
                  'Vyber do jaké věkové skupiny patříš:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                const Text(
                  'Výběr skupin ovlivní obtížnost testů.\nSkupin je možné vybrat víc.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
                ),

                const SizedBox(height: 10.0),

                // Display error message
                ErrorMessage(
                  message: errorMessage,
                   visibility: errorVisibility
                  ),

                const SizedBox(height: 5.0),

                // Container for school group selection
                SchoolGroupSelection(
                  schoolGroups: schoolGroups,
                  selectedGroups: selectedGroups,
                  onGroupSelectionChanged: (int groupId, bool isSelected) {
                  setState(() {
                      if (isSelected) {
                        selectedGroups.add(groupId);
                      } else {
                        selectedGroups.remove(groupId);
                      }
                    });
                  },
                ),

                const SizedBox(height: 5.0),

                // Register button
                ContinueButton(
                  height: 55,
                  text: 'Pokračovat',
                  onPressed: _save,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
