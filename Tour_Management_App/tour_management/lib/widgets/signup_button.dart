import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  final VoidCallback _onPressed;

  SignUpButton({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black,
      height: 50,
      color: Colors.white,
      textColor: Colors.blue,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      onPressed: _onPressed,
      child: Text(
        'Sign-up',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
