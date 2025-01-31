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
          child: Text(
            'Přehled',
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        GridView.builder(
          shrinkWrap: true, 
          physics:
              NeverScrollableScrollPhysics(), // Zakáže scrollování uvnitř GridView
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 sloupce v mřížce
            crossAxisSpacing: 8.0, // Mezery mezi sloupci
            mainAxisSpacing: 8.0, // Mezery mezi řádky
            childAspectRatio: 1.0, // Poměr výšky a šířky jednotlivých karet
          ),
          itemCount: 4, // Počet kartiček v mřížce
          itemBuilder: (context, index) {
            return Card(
              child: BorderContainer(padding: 16, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Uživatelský výkon ${index + 1}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // Přidejte další informace podle potřeby
                    Text('Počet návštěv:'),
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
