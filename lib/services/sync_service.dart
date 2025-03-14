import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:plant_puzzle_app/services/data_service_worksheets.dart';
import 'dart:async';
import 'data_service.dart';

class SyncService {
  static final SyncService _instance = SyncService._internal();
  final DataService _dataService = DataService();
  final DataServiceWorksheets _dataServiceWorksheets = DataServiceWorksheets();
  Timer? _syncTimer;
  Timer? _syncTimerResults;

  factory SyncService() => _instance;

  SyncService._internal();

  void startSync() {
    _syncTimer?.cancel();
    _syncTimer = Timer.periodic(Duration(minutes: 5), (timer) async {
      await _checkAndSync();
    });

    _syncTimerResults?.cancel();
    _syncTimerResults = Timer.periodic(Duration(minutes: 2), (timer) async {
      await _checkAndSyncResults();
    });
  }

  Future<void> _checkAndSyncResults() async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult.contains(ConnectivityResult.wifi)) {
      await _dataServiceWorksheets.syncWorksheetResults();
    }
  }

  Future<void> _checkAndSync() async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult.contains(ConnectivityResult.wifi)) {
      await _dataService.fetchAndCacheData();
    }
  }

  void stopSync() {
    _syncTimer?.cancel();
    _syncTimerResults?.cancel();
  }
}

