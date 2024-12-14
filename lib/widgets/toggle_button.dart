import 'package:flutter/material.dart';
import '../utilities/worksheets.dart';

class ToggleButton extends StatefulWidget {
  final String text;
  final double? width;
  final double? height;
  final Function(bool)? onToggle;

  const ToggleButton({
    super.key,
    this.text = 'Tlačítko',
    this.height = 45.0,
    this.width,
    this.onToggle,
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
      isSelected = !isSelected;
    });
  }

  void resetButton() {
    setState(() {
      isSelected = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<PageState>(
      stream: stateManager.pageStateStream,
      builder: (context, pageStateSnapshot) {
        final pageState = pageStateSnapshot.data ?? PageState.answer;
        Color backgroundColor;

        if (pageState == PageState.evaluate && isSelected) {
          backgroundColor = Colors.green;
        } else {
          backgroundColor = isSelected ? Colors.grey.shade300 : Colors.white;
        }

        print('PageState: $pageState, _isSelected: $isSelected, backgroundColor: $backgroundColor');

        return Align(
          alignment: Alignment.center,
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                width: 2.0,
                color: Colors.grey.shade300,
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
                setState(() {
                  isSelected = !isSelected;
                });
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  widget.text,
                  style: const TextStyle(fontSize: 16.0),
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
