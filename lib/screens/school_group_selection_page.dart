import 'package:flutter/material.dart';
import '../widgets/buttons/continue_button.dart';
import '../widgets/border_container.dart';
import '../widgets/error_message.dart';
import '../services/api_service_visitors.dart';
import '../models/visitors.dart';
import 'area_list_page.dart';


class SchoolGroupSelectionPage extends StatefulWidget {
  final String username;
  final String firstName;
  final String lastName;

  const SchoolGroupSelectionPage({
    super.key,
    required this.username,
    required this.firstName,
    required this.lastName,
  });

  @override
  State<SchoolGroupSelectionPage> createState() =>
      _SchoolGroupSelectionPageState();
}

class _SchoolGroupSelectionPageState extends State<SchoolGroupSelectionPage> {
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
  void _register() async {
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
        username: widget.username,
        firstName: widget.firstName,
        lastName: widget.lastName,
        schoolGroupIds: selectedGroups,
      );

      await apiService.registerUser(visitor);

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

                // Greeting text
                Text(
                  'Vítej, ${widget.username}!',
                  style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Vyber do jaké věkové skupiny patříš:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                const Text(
                  'Skupin je možné vybrat víc.',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 15.0),

                // Display error message
                ErrorMessage(
                  message: errorMessage,
                   visibility: errorVisibility
                  ),

                const SizedBox(height: 5.0),

                // Container for school group selection
                BorderContainer(
                  children: [
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: schoolGroups.length,
                      itemBuilder: (context, index) {
                        final group = schoolGroups[index];

                        return CheckboxListTile(
                          title: Text(group['group']),
                          value: selectedGroups.contains(group['id']),
                          fillColor: WidgetStateProperty.resolveWith<Color>(
                              (Set<WidgetState> states) {
                            if (states.contains(WidgetState.selected)) {
                              return const Color(0xFF93C572);
                            }
                            return Colors.white;
                          }),
                          side: BorderSide(color: Colors.grey.shade400),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true) {
                                selectedGroups.add(group['id']);
                              } else {
                                selectedGroups.remove(group['id']);
                              }
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),

                // Register button
                ContinueButton(
                  height: 55,
                  text: 'Registrovat se',
                  onPressed: _register,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
