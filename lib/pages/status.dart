import 'package:flutter/material.dart';
import 'package:band_name/services/socket_service.dart';
import 'package:provider/provider.dart';

class StatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Server Status ${socketService.serverStatus}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          socketService.emit!(
              'nuevo-mensaje', {'name': 'Daniel', 'message': 'Hola pacoa'});
        },
        child: Icon(Icons.message),
      ),
    );
  }
}
