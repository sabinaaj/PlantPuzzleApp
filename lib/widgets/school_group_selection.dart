import 'package:flutter/material.dart';
import '../widgets/border_container.dart';
import '../models/visitors.dart';
import '../colors.dart';

class SchoolGroupSelection extends StatelessWidget {
  final List<SchoolGroup> schoolGroups;
  final List<int> selectedGroups;
  final Function(int, bool) onGroupSelectionChanged;

  const SchoolGroupSelection({
    super.key,
    required this.schoolGroups,
    required this.selectedGroups,
    required this.onGroupSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      children: [
        ListView.builder(
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: schoolGroups.length,
          itemBuilder: (context, index) {
            final group = schoolGroups[index];

            return CheckboxListTile(
              title: Text(group.name),
              value: selectedGroups.contains(group.id),
              fillColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppColors.primaryGreen;
                  }
                  return Colors.white;
                },
              ),
              side: BorderSide(color: Colors.grey.shade400),
              onChanged: (bool? value) {
                if (value != null) {
                  onGroupSelectionChanged(group.id, value);
                }
              },
            );
          },
        ),
      ],
    );
  }
}