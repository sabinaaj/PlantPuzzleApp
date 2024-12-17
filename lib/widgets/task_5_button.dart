import 'package:flutter/material.dart';
import '../utilities/worksheet.dart';

class Task5Button extends StatefulWidget {
  final String? text;
  final VoidCallback? onPressed;
  final bool Function()? canBeSelected;

  const Task5Button({
    super.key,
    this.text,
    this.onPressed,
    this.canBeSelected,
  });

  @override
  State<Task5Button> createState() => Task5ButtonState();
}

class Task5ButtonState extends State<Task5Button> {
  late final StateManager stateManager;
  bool isSelected = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    stateManager = StateManagerProvider.of(context);
  }
  
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<PageState>(
      stream: stateManager.pageStateStream,
      builder: (context, pageStateSnapshot) {
        final pageState = pageStateSnapshot.data ?? PageState.answer;
        Color backgroundColor = isSelected ? Colors.grey.shade300 : Colors.white;
        Color textColor = Colors.black;
        Color borderColor = isSelected ? Colors.grey.shade400 : Colors.grey.shade300;

        return Align(
          alignment: Alignment.center,
          child: Container(
            width: double.infinity,
            height: double.infinity,
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
                print(widget.canBeSelected?.call() ?? true);
                if (widget.canBeSelected?.call() ?? true) {
                  widget.onPressed?.call();
                  
                  pageState == PageState.answer
                  ? setState(() {
                    isSelected = !isSelected;
                    })
                  : null;
                }
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  widget.text ?? '',
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
