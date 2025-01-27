import 'package:flutter/material.dart';
import '../widgets/border_container.dart';
import '../models/visitors.dart';
import '../colors.dart';

class UserSchoolContainer extends StatelessWidget {
  final Visitor visitor;

  const UserSchoolContainer({
    super.key,
    required this.visitor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Moje údaje',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit_outlined,
                    size: 25.0, color: AppColors.secondaryGreen),
                onPressed: () {},
              )
            ],
          ),
        ),
        BorderContainer(
          padding: 12.0,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
            ),
            Text(
              'Moje údaje',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 30.0),
          ],
        ),
      ],
    );
  }
}
