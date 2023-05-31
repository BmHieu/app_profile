import 'package:connectivity/connectivity.dart';
import 'package:dailycanhan/config/config.dart';
import 'dart:async';
import 'dart:io';

class InternetConnectivity {
  InternetConnectivity._internal();

  static final InternetConnectivity _instance = InternetConnectivity._internal();
  static InternetConnectivity get instance => _instance;

  Connectivity connectivity = Connectivity();
  StreamController controller = StreamController.broadcast();
  Stream get myStream => controller.stream;

  void initialise() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    _checkStatus(result);
    connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup(ConfigApp.baseURL);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isOnline = true;
      } else {
        isOnline = false;
      }
    } on SocketException catch (_) {
      isOnline = false;
    }
    if (controller.isClosed) {
      controller = StreamController.broadcast();
    }
    controller.sink.add({result: isOnline});
  }

  void disposeStream() => controller.close();
}
