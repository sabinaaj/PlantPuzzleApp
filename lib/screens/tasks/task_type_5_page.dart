import 'package:flutter/material.dart';
import '../../widgets/border_button.dart';
import '../../widgets/continue_button.dart';

class TaskType5Page extends StatefulWidget {
  TaskType5Page();

  @override
  _TaskType5PageState createState() => _TaskType5PageState();
}

class _TaskType5PageState extends State<TaskType5Page> {
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
            Expanded(
              child: Row(
                children: [
                  // První sloupec tlačítek
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start, // Align to the top
                        children: [
                          Flexible(
                            fit: FlexFit.tight,
                            child: BorderButton(
                              text: 'ano',
                              width: double.infinity,
                              height: 100,
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: BorderButton(
                              text: 'ne',
                              width: double.infinity,
                              height: 100,
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: BorderButton(
                              text: 'ne',
                              width: double.infinity,
                              height: 100,
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: BorderButton(
                              text: 'ne',
                              width: double.infinity,
                              height: 100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Druhý sloupec tlačítek
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start, // Align to the top
                        children: [
                          Flexible(
                            fit: FlexFit.tight,
                            child: BorderButton(
                              text: 'ano',
                              width: double.infinity,
                              height: 100,
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: BorderButton(
                              text: 'ne',
                              width: double.infinity,
                              height: 100,
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: BorderButton(
                              text: 'ne',
                              width: double.infinity,
                              height: 100,
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: BorderButton(
                              text: 'ne',
                              width: double.infinity,
                              height: 100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            ContinueButton(
              text: 'Vyhodnotit',
            ),
          ],
        ),
      ),
    );
  }
}
