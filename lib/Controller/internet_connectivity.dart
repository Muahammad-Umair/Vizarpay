import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

enum Connection {
  connected,
  disconnected,
}

class InternetConnectivityP extends ChangeNotifier {
  Connection _internet = Connection.disconnected;

  InternetConnectivityP() {
    Connectivity().onConnectivityChanged.listen((_updateStatus));
  }

  Connection get hasInternet => _internet;

  void checkInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      _internet = Connection.connected;
      notifyListeners();
    } else {
      _internet = Connection.disconnected;
      notifyListeners();
    }
  }

  void _updateStatus(ConnectivityResult connectivityResult) async {
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      _internet = Connection.connected;
      notifyListeners();
    } else {
      _internet = Connection.disconnected;
      notifyListeners();
    }
  }
}
