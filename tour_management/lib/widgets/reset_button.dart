import 'package:flutter/material.dart';

//Widget for the reset button
class ResetButton extends StatelessWidget {
  final VoidCallback _onTapped;
  ResetButton({Key key, @required VoidCallback onTapped})
      : _onTapped = onTapped,
        super(key: key);

//Building the widget for the reset button
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black.withOpacity(0.3),
      height: 50,
      color: Colors.blue,
      textColor: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      onPressed: _onTapped,
      child: Text(
        'Send recover email',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
