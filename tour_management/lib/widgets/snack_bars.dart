import 'package:flutter/material.dart';
import 'package:chpnt_repo_manager/chpnt_repo_manager.dart';

//Collection of snackbars
Widget registerSnack() {
  return SnackBar(
    content: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text('Creating your account...'),
      CircularProgressIndicator()
    ]),
    backgroundColor: Colors.blue,
  );
}

Widget loginSnack() {
  return SnackBar(
    content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text('Login in progress...'), CircularProgressIndicator()]),
    backgroundColor: Colors.black,
  );
}

Widget failedLoginSnack() {
  return SnackBar(
    content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text('Login failed'), Icon(Icons.error)]),
    backgroundColor: Colors.red,
  );
}

Widget failedRegSnack() {
  return SnackBar(
    content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text('Registration failed'), Icon(Icons.error)]),
    backgroundColor: Colors.red,
  );
}

Widget resetSnack() {
  return SnackBar(
    content: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text('Sending recover steps to your email...'),
      CircularProgressIndicator()
    ]),
    backgroundColor: Colors.black,
  );
}

Widget failedResetSnack() {
  return SnackBar(
    content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text('Failed to send'), Icon(Icons.error)]),
    backgroundColor: Colors.red,
  );
}

class CheckpointDeleteSnack extends SnackBar {
  CheckpointDeleteSnack(
      {Key key,
      @required CheckpointModel checkpoint,
      @required VoidCallback onUndo})
      : super(
            key: key,
            content: Text(
              'Checkpoint deleted',
              style: TextStyle(color: Colors.redAccent),
            ),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.black,
            action: SnackBarAction(label: 'Undo', onPressed: onUndo));
}
