import 'package:flutter/material.dart';
import '../../widgets/border_button.dart';
import '../../widgets/continue_button.dart';

class TaskType1Page extends StatelessWidget {
  const TaskType1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('uloha 1'),
        centerTitle: true,
      ),
      body: SafeArea(
        top: true,
        child: Align(
          alignment: AlignmentDirectional(0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: AlignmentDirectional(-1, -1),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Zadání',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Hello World',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BorderButton(
                        text: 'Button',
                      ),
                      BorderButton(
                        text: 'Button',
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.25),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: 
                  ContinueButton(
                    text: 'Pokračovat',
                    width: double.infinity,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}