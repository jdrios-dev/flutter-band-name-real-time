import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting,
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket? _socket;

  ServerStatus get serverStatus => _serverStatus;

  IO.Socket? get socket => _socket;

  void Function(String event, [dynamic data])? get emit => _socket?.emit;

  SocketService() {
    _initConfig();
  }

  void _initConfig() {
    _socket = IO.io(
        'ws://10.0.2.2:3000/',
        //'htpp://localhost:3000',
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .build());
    _socket?.onConnect((_) {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    _socket?.onDisconnect((_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
    // _socket.on('nuevo-mensaje', (data) {
    //   print('nuevo mensaje, $data.name');
    //   notifyListeners();
    // });
  }

  void on(String s, Null Function(dynamic payload) param1) {}
}
