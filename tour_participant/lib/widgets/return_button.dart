import 'package:flutter/material.dart';

class PopBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return FlatButton(
      child: Text(
        'Login here!',
        style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.blue,
            fontSize: 16),
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
