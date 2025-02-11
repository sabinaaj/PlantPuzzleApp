import 'package:flutter/material.dart';
import '../services/sync_service.dart';

class AppLifecycleManager extends StatefulWidget {
  final Widget child;

  const AppLifecycleManager({super.key, required this.child});

  @override
  State<AppLifecycleManager> createState() => _AppLifecycleManagerState();
}

class _AppLifecycleManagerState extends State<AppLifecycleManager> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    SyncService().stopSync(); // Stop synchronization before app closes
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      print("App paused or detached. Stopping sync.");
      SyncService().stopSync();
    } else if (state == AppLifecycleState.resumed) {
      print("App resumed. Starting sync.");
      SyncService().startSync();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
