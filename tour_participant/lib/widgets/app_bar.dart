import 'package:flutter/material.dart';

//Collection of app bars
AppBar welcomeAppBar() {
  return AppBar(
    centerTitle: true,
    title: Text('Welcome'),
  );
}

AppBar checkpointAppBar() {
  return AppBar(
      centerTitle: true,
      title: Text(
        'Checkpoint Panel',
        style: TextStyle(fontSize: 24),
      ),
      backgroundColor: Colors.redAccent);
}

AppBar feedbackAppBar() {
  return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text(
        'Feedback Panel',
        style: TextStyle(fontSize: 24),
      ),
      backgroundColor: Colors.redAccent);
}
