import 'package:flutter/material.dart';

//Collection of app bars
AppBar welcomeAppBar() {
  return AppBar(
    title: Text('Welcome'),
  );
}

AppBar managerCheckpointAppbar() {
  return AppBar(
      title: Text(
        'Checkpoint Panel',
        style: TextStyle(fontSize: 24),
      ),
      backgroundColor: Colors.redAccent);
}
