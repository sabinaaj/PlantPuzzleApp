import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../widgets/school_group_selection.dart';
import '../widgets/border_container.dart';
import '../models/visitors.dart';
import '../services/data_service_visitors.dart';
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
  final DataServiceVisitors dataService = DataServiceVisitors();
  late Future<List<SchoolGroup>> schoolGroups;
  List<int> selectedGroups = [];
  bool isEditing = false;
  bool isConnected = false;

  // Variables for error handling
  String errorMessage = '';
  bool errorVisibility = false;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    schoolGroups = _fetchSchoolGroups();
    selectedGroups = widget.visitor.schoolGroupIds ?? [];
  }

  /// Fetch school groups from the API
  Future<List<SchoolGroup>> _fetchSchoolGroups() async {
    if (isConnected) {
      return await apiService.getSchoolGroups();
    } else {
      return dataService.getSchoolGroups();
    }
  }

  /// Check connectivity
  Future<void> _checkConnectivity() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    setState(() {
      isConnected = connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SchoolGroup>>(
      future: schoolGroups,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text('Stránku se nepodařilo načíst. Zkuste to znovu.'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Stránka nenalezena.'));
        }

        final schoolGroups = snapshot.data!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      const Text(
                        'Školní skupiny',
                        style: TextStyle(
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
                              onPressed: isConnected
                                  ? () => setState(() {
                                        if (selectedGroups.isNotEmpty) {
                                          widget.visitor.schoolGroupIds =
                                              selectedGroups;
                                          apiService
                                              .updateVisitor(widget.visitor);
                                        }
                                        isEditing = !isEditing;
                                      })
                                  : null,
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
                          ],
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.edit_outlined,
                            size: 25.0,
                            color: isConnected
                                ? AppColors.secondaryGreen
                                : Colors.grey,
                          ),
                          onPressed: isConnected
                              ? () => setState(() => isEditing = !isEditing)
                              : () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Úpravy nejsou dostupné bez připojení k internetu.',
                                      ),
                                    ),
                                  );
                                },
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
                : BorderContainer(
                    children: [
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: schoolGroups.length,
                        itemBuilder: (context, index) {
                          final group = schoolGroups[index];
                          return ListTile(
                            title: Text(group.name),
                            trailing: widget.visitor.schoolGroupIds
                                        ?.contains(group.id) ??
                                    false
                                ? const Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: Icon(Icons.check,
                                        color: AppColors.primaryGreen))
                                : const Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: Icon(Icons.check,
                                        color: Colors.transparent)),
                          );
                        },
                      ),
                    ],
                  ),
          ],
        );
      },
    );
  }
}
