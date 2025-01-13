import 'package:flutter/material.dart';
import '../widgets/buttons/continue_button.dart';
import '../widgets/border_container.dart';
import '../services/api_service_visitors.dart';
import 'area_list_page.dart';

class SchoolGroupSelectionPage extends StatefulWidget {
  final String username;
  final String firstName;
  final String lastName;

  SchoolGroupSelectionPage({
    required this.username,
    required this.firstName,
    required this.lastName,
  });

  @override
  _SchoolGroupSelectionPageState createState() =>
      _SchoolGroupSelectionPageState();
}

class _SchoolGroupSelectionPageState extends State<SchoolGroupSelectionPage> {
  final ApiService _apiService = ApiService();
  List<dynamic> schoolGroups = [];
  List<int> selectedGroups = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSchoolGroups();
  }

  Future<void> _fetchSchoolGroups() async {
    try {
      final groups = await _apiService.getSchoolGroups();
      setState(() {
        schoolGroups = groups;
        isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nepodařilo se načíst školní skupiny.')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  void _register() async {
    if (selectedGroups.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vyberte alespoň jednu školní skupinu.')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await _apiService.registerUser(
        widget.username,
        widget.firstName,
        widget.lastName,
        schoolGroupsIds: selectedGroups,
      );

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => AreaListPage()),
          (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registrace se nezdařila. Zkuste to znovu.')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Vítej, ${widget.username}!',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Vyber do jaké věkové skupiny patříš:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Skupin je možné vybrat víc. ',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15.0),

                  BorderContainer(
                  children: [ ListView.builder(
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

                  ContinueButton(
                    height: 55,
                    text: isLoading ? 'Načítám...' : 'Registrovat se',
                    onPressed: isLoading ? null : _register,
                  ),
                ],
              ),
      ),
    ),
  );
}

}
