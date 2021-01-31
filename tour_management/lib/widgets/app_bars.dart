import 'package:flutter/material.dart';
import 'package:tour_management/widgets/group_filter_button.dart';

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

AppBar groupAppBar() {
  return AppBar(
      centerTitle: true,
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

AppBar profileEditAppBar() {
  return AppBar(
    centerTitle: true,
    title: Text("Edit Profile", style: TextStyle(fontSize: 24)),
    backgroundColor: Colors.amber,
  );
}

AppBar feedbackDetailsAppBar() {
  return AppBar(
    centerTitle: true,
    title: Text("Feedback Details", style: TextStyle(fontSize: 24)),
    backgroundColor: Colors.redAccent,
  );
}

AppBar feedbackAppBar() {
  return AppBar(
      centerTitle: true,
      title: Text(
        'Feedback Panel',
        style: TextStyle(fontSize: 24),
      ),
      backgroundColor: Colors.redAccent);
}

AppBar chatAppBar() {
  return AppBar(
      centerTitle: true,
      title: Text(
        'Chat Panel',
        style: TextStyle(fontSize: 24),
      ),
      backgroundColor: Colors.blue);
}
