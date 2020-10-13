import 'package:flutter/material.dart';

class PopBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        'Login here!',
        style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.white,
            fontSize: 16),
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
