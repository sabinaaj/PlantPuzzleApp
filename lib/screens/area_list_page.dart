import 'package:flutter/material.dart';
import '../widgets/area_list.dart';
import 'user_page.dart';

class AreaListPage extends StatelessWidget {
  const AreaListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 130.0,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
            icon: Image.asset('assets/images/plant.png', height: 30),
            onPressed: () {},
          ),
          const Text(
          'Oblasti',
          style: TextStyle(fontSize: 22.0),
        ),
          ],
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/images/map.png', height: 30),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
            icon: Image.asset('assets/images/user.png', height: 30),
            onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserPage(),
                    ),
                  );
                },
          ))
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Divider(
            height: 2.0,
            color: Colors.grey.shade300,
            thickness: 2.0,
          ),
        ),
      ),
      body: const AreaList(),
    );
  }
}
