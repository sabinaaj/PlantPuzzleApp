import 'package:flutter/material.dart';
import '../widgets/school_group_selection.dart';
import '../widgets/border_container.dart';
import '../models/visitors.dart';
import '../services/api_service_visitors.dart';
import '../colors.dart';

class UserSchoolContainer extends StatefulWidget {
  final Visitor visitor;

  const UserSchoolContainer({
    super.key,
    required this.visitor,
  });

  @override
  State<UserSchoolContainer> createState() => _UserSchoolContainerState();
}

class _UserSchoolContainerState extends State<UserSchoolContainer> {
  final ApiService apiService = ApiService();
  late Future<List<dynamic>> schoolGroups;
  List<int> selectedGroups = [];
  bool isEditing = false;

  // Variables for error handling
  String errorMessage = '';
  bool errorVisibility = false;

  @override
  void initState() {
    super.initState();
    schoolGroups = _fetchSchoolGroups();
    selectedGroups = widget.visitor.schoolGroupIds ?? [];
  }

  /// Fetch school groups from the API
  Future<List<dynamic>> _fetchSchoolGroups() async {
    return await apiService.getSchoolGroups();
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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/school.png',
                      width: 30.0,
                      height: 30.0,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                  'Školní skupiny',
                  style: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                  ],
                ),
                  isEditing
                    ? Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.done,
                            size: 25.0,
                            color: AppColors.secondaryGreen,
                          ),
                          onPressed: () => 
                            setState(() {
                              if (selectedGroups.isNotEmpty) {
                                widget.visitor.schoolGroupIds = selectedGroups;
                                apiService.updateVisitor(widget.visitor);
                              }
                              isEditing = !isEditing;
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.close,
                            size: 25.0,
                            color: AppColors.secondaryRed,
                          ),
                          onPressed: () =>
                              setState(() => isEditing = !isEditing),
                        ),
                      ])
                    : IconButton(
                        icon: const Icon(
                          Icons.edit_outlined,
                          size: 25.0,
                          color: AppColors.secondaryGreen,
                        ),
                        onPressed: () =>
                            setState(() => isEditing = !isEditing),
                      ),
                ],
              ),
            ),
            isEditing
              ? SchoolGroupSelection(
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
                )
              :
              BorderContainer(
                  children: [
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: schoolGroups.length,
                      itemBuilder: (context, index) {
                        final group = schoolGroups[index];

                        return ListTile(
                          title: Text(group['group']),
                          trailing: widget.visitor.schoolGroupIds
                                      ?.contains(group['id']) ??
                                  false
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: const Icon(Icons.check,
                                      color: AppColors.primaryGreen))
                              : Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: const Icon(Icons.check,
                                      color: Colors.transparent)),
                        );
                      },
                    ),
                  ],
                )
          ],
        );
      },
    );
  }
}
