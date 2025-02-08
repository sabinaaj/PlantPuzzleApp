import 'package:connectivity_plus/connectivity_plus.dart';


void monitorConnection(Function onConnected) async {
  final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult.contains(ConnectivityResult.wifi)) {
    print('Connected to the internet.');
    onConnected();
  }
}

