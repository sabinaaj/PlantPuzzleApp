import 'package:flutter/material.dart';
import '../widgets/areas/area_list.dart';
import '../widgets/navigation_app_bar.dart';

class AreaListPage extends StatelessWidget {
  const AreaListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // AppBar
      appBar: NavigationAppBar(
        leadingWidth: 130.0,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.asset('assets/images/plant.png', height: 30)),
            const Text(
              'Oblasti',
              style: TextStyle(fontSize: 22.0),
            ),
          ],
        ),

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Divider(
            height: 2.0,
            color: Colors.grey.shade300,
            thickness: 2.0,
          ),
        ),
      ),

      // Area list
      body: const AreaList(),
    );
  }
}
