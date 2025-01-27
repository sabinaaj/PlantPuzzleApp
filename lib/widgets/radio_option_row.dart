import 'package:flutter/material.dart';
import '../../colors.dart';

class OptionRow extends StatelessWidget {
  final String label;
  final String value;
  final String groupValue;
  final ValueChanged<String> onChanged;

  const OptionRow({
    super.key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<String>(
          groupValue: groupValue,
          value: value,
          fillColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.primaryGreen;
              }
              return Colors.grey.shade400;
            },
          ),
          onChanged: (String? selected) {
            if (selected != null) {
              onChanged(selected);
            }
          },
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}