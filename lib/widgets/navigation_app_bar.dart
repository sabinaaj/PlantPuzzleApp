import 'package:flutter/material.dart';
import '../screens/user_page.dart';

class NavigationAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  NavigationAppBar({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight + 4.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: Divider(
          height: 2.0,
          color: Colors.grey.shade300,
          thickness: 2.0,
        ),
      ),
    );
  }
}
