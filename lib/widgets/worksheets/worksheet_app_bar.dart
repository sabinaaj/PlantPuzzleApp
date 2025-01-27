import 'package:flutter/material.dart';
import '../../colors.dart';

class WorksheetAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double progressValue;
  final VoidCallback onClose;

  const WorksheetAppBar({
    super.key,
    required this.title,
    required this.progressValue,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(fontSize: 20.0),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Ukončit test"),
                content: const Text("Opravdu chceš skončit?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Ne"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onClose();
                    },
                    child: const Text("Ano"),
                  ),
                ],
              );
            },
          );
        },
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: LinearProgressIndicator(
          borderRadius: BorderRadius.circular(8.0),
          minHeight: 6.0,
          value: progressValue,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryGreen),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 6.0);
}
