import 'package:flutter/material.dart';

//Widget of the login button
class LoginButton extends StatelessWidget {
  final VoidCallback _onPressed;
  LoginButton({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

//Building the button widget
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
        'Login',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
