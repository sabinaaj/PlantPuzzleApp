import 'package:flutter/material.dart';
import '../../widgets/border_button.dart';
import '../../widgets/continue_button.dart';

class TaskType1Page extends StatefulWidget {
  TaskType1Page();

  @override
  _TaskType1PageState createState() => _TaskType1PageState();
}

class _TaskType1PageState extends State<TaskType1Page> {
  final GlobalKey _button1Key = GlobalKey();
  final GlobalKey _button2Key = GlobalKey();

  double _maxWidth = 0;

  @override
  void initState() {
    super.initState();
    _maxWidth = _calculateMaxTextWidth(['ano', 'ne']);
    print(_maxWidth);
  }

  double _calculateMaxTextWidth(List<String> texts) {
    final textStyle = TextStyle(fontSize: 16.0); // Styl textu
    double maxWidth = 0;

    for (final text in texts) {
      final textPainter = TextPainter(
        text: TextSpan(text: text, style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      maxWidth = maxWidth > textPainter.width ? maxWidth : textPainter.width;
      print(textPainter.width);
      print(maxWidth);
    }

    return maxWidth + 40.0; // Přidání paddingu
  }

  @override
  Widget build(BuildContext context) {
    String? selectedOption;

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vyber správnou možnost:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
            ),
            Column(
              children: [
                Text(
                  "question",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BorderButton(
                      key: _button1Key,
                      text: 'ano',
                      height: 50,
                      width: _maxWidth,
                    ),
                    BorderButton(
                      key: _button2Key,
                      text: 'ne',
                      height: 50,
                      width: _maxWidth,
                    ),
                  ],
                ),
                SizedBox(height: 100),
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
