import 'package:flutter/material.dart';
import '../../widgets/border_button.dart';
import '../../widgets/continue_button.dart';
import '../../models/worksheet.dart';

class TaskType2Page extends StatelessWidget {
  final Task task;

  const TaskType2Page({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Title'),
          actions: [
            IconButton(
              icon: const Icon(Icons.account_circle),
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
                task.text,
                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
              ),
              // Question text
              Align(
                alignment: Alignment.center,
                child: Text(
                  task.questions[0].text ?? '',
                  style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),

              // Options
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: task.questions[0].options.map((option) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 14.0),
                    child: BorderButton(text: option.text ?? '', height: 50, width: double.infinity),
                  );
                }).toList() 
              ),
              ContinueButton(
                text: 'Vyhodnotit',
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
    );
  }
}
