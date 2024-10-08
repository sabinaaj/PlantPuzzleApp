import 'package:flutter/material.dart';
import '../widgets/area_list.dart';  

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Seznam oblastí'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Divider(
            height: 2.0,
            color: Colors.grey.shade300, 
            thickness: 2.0,
          ),
  ),
      ),
      body:
       ItemList(), 
    );
  }
}
