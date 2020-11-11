import 'package:flutter/material.dart';
import 'package:tour_management/widgets/group_filter_button.dart';

//Collection of app bars
AppBar welcomeAppBar() {
  return AppBar(
    title: Text('Welcome'),
  );
}

AppBar checkpointAppBar() {
  return AppBar(
      title: Text(
        'Checkpoint Panel',
        style: TextStyle(fontSize: 24),
      ),
      backgroundColor: Colors.redAccent);
}

AppBar groupAppBar() {
  return AppBar(
      title: Text(
        'Group Panel',
        style: TextStyle(fontSize: 24),
      ),
      actions: [
        FilterButton(
          visible: true,
        )
      ],
      backgroundColor: Colors.green);
}

AppBar profileAppBar() {
  return AppBar(
    title: Text("Profile Panel"),
    backgroundColor: Colors.amber,
  );
}

AppBar profileEditAppBar() {
  return AppBar(
    title: Text("Edit Profile"),
    backgroundColor: Colors.amber,
  );
}
