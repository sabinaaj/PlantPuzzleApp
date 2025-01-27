import 'package:flutter/material.dart';
import '../../models/visitors.dart';

class UserHeader extends StatelessWidget {
  final Visitor visitor;

  const UserHeader({super.key, required this.visitor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
          child: Image.asset(
            'assets/images/user.png',
            height: 50,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            Text(
              visitor.username,
              style: const TextStyle(
                height: 1.1,
                fontSize: 24.0,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              '${visitor.firstName} ${visitor.lastName}',
              style: const TextStyle(
                fontSize: 16.0,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ])
      ],
    );
  }
}
