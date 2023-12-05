import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> isConnected();

  Future<bool> isNotConnected();
}

class NetworkProvider implements NetworkInfo {
  final Connectivity _connectivity;

  NetworkProvider(this._connectivity);

  StreamController connectionChangeController = StreamController.broadcast();

  Stream get connectionChange => connectionChangeController.stream;

  void dispose() {
    connectionChangeController.close();
  }

  @override
  Future<bool> isConnected() {
    return _connectivity
        .checkConnectivity()
        .then((value) => value != ConnectivityResult.none);
  }

  @override
  Future<bool> isNotConnected() async {
    return !(await isConnected());
  }
}
