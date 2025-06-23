import 'package:flutter/material.dart';
import '../screens/user_page.dart';

class NavigationAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final Widget? leading;
  final double? leadingWidth;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;

  const NavigationAppBar(
    {this.leading,
    this.leadingWidth,
    this.bottom,
    this.backgroundColor,
    super.key})
      : preferredSize = const Size.fromHeight(kToolbarHeight + 4.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      leadingWidth: leadingWidth,
      leading: leading,
      actions: [
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
      bottom: bottom,
    );
  }
}
