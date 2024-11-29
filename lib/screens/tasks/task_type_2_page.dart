import 'package:flutter/material.dart';
import '../../widgets/border_button.dart';
import '../../widgets/continue_button.dart';

class TaskType2Page extends StatefulWidget {
  TaskType2Page();

  @override
  _TaskType2PageState createState() => _TaskType2PageState();
}

class _TaskType2PageState extends State<TaskType2Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Akce pro ikonu uživatele
            },
          ),
        ],
      ),
      body: const Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vyber správnou možnost:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
              "question",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),),
            
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 14),

                BorderButton(text: 'ano', height: 50, width: double.infinity),
                SizedBox(height: 14),

                BorderButton(text: 'ne', height: 50, width: double.infinity),
                SizedBox(height: 14),

                BorderButton(text: 'ne', height: 50, width: double.infinity),
                SizedBox(height: 14),

                BorderButton(text: 'ne', height: 50, width: double.infinity),
              ],
            ),
            ContinueButton(
              text: 'Vyhodnotit',
            ),
          ],
        ),
      ),
    );
  }
}
