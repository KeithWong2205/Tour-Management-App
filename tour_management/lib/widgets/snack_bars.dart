import 'package:flutter/material.dart';

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
    backgroundColor: Colors.blue,
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
    backgroundColor: Colors.blue,
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
