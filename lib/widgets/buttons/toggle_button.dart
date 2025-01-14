import 'package:flutter/material.dart';
import '../../utilities/worksheet.dart';
import '../../../models/worksheet.dart';

class ToggleButton extends StatefulWidget {
  final Option? option;
  final double? width;
  final double? height;
  final bool multipleSelection;

  const ToggleButton({
    super.key,
    this.option,
    this.height = 50.0,
    this.width,
    this.multipleSelection = false,
  });

  @override
  State<ToggleButton> createState() => ToggleButtonState();
}

class ToggleButtonState extends State<ToggleButton> {
  late final StateManager stateManager;
  bool isSelected = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    stateManager = StateManagerProvider.of(context);
    stateManager.registerButton(this);
  }

  @override
  void dispose() {
    stateManager.unregisterButton(this);
    super.dispose();
  }

  void toggleSelection() {
    setState(() {
      if (!widget.multipleSelection) {
        stateManager.resetButtons();
      }

      isSelected = !isSelected;
    });
  }

  void resetButton() {
    setState(() {
      isSelected = false;
    });
  }

  bool getIsSelected() {
    return isSelected;
  }

  Option? getOption() {
    return widget.option;
  }
  
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<PageState>(
      stream: stateManager.pageStateStream,
      builder: (context, pageStateSnapshot) {
        final pageState = pageStateSnapshot.data ?? PageState.answer;
        Color backgroundColor;
        Color textColor;
        Color borderColor;

        if (pageState == PageState.evaluate && isSelected) {
          if (widget.option?.isCorrect ?? false) {
            backgroundColor = const Color.fromARGB(230, 147, 197, 114);
            textColor = Colors.white;
            borderColor = const Color.fromARGB(230, 106, 156, 73);
          } else {
            backgroundColor = const Color.fromARGB(230, 248, 113, 113);
            textColor = Colors.white;
            borderColor = const Color.fromARGB(230, 239, 68, 68);
          }
        } else if (widget.option != null && pageState == PageState.evaluate && widget.option!.isCorrect) {
          backgroundColor = const Color.fromARGB(255, 159, 201, 131);
          textColor = Colors.white;
          borderColor = const Color.fromARGB(255, 113, 170, 75);
        } else {
          backgroundColor = isSelected ? Colors.grey.shade300 : Colors.white;
          textColor = Colors.black;
          borderColor = isSelected ? Colors.grey.shade400 : Colors.grey.shade300;
        }

        return Align(
          alignment: Alignment.center,
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border(
                top: BorderSide(width: 2.0, color: borderColor),
                left: BorderSide(width: 2.0, color: borderColor),
                right: BorderSide(width: 2.0, color: borderColor),
                bottom: BorderSide(width: 4.0, color: borderColor), // Thicker bottom border
              ),
              color: backgroundColor,
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                pageState == PageState.answer
                ? toggleSelection()
                : null;
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  widget.option?.text ?? '',
                  style: TextStyle(fontSize: 16.0, color: textColor),
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
