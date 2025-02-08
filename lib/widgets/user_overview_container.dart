import 'package:flutter/material.dart';
import '../widgets/border_container.dart';
import '../../models/visitors.dart';

class UserOverviewContainer extends StatelessWidget {
  final Visitor visitor;

  const UserOverviewContainer({
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
          child: 
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/graph.png',
                width: 28.0,
                height: 28.0,
              ),
              const SizedBox(width: 8.0),
              Text(
            'Přehled',
            style: const TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w500,
            ),
          ),
            ],
          )
        ),

        GridView.builder(
          shrinkWrap: true, 
          physics:
              NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 1.05,
          ),
          itemCount: 4, 
          itemBuilder: (context, index) {
            return Card(
              child: BorderContainer(padding: 16, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${index + 1}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ]),
            );
          },
        ),
      ],
    );
  }
}
