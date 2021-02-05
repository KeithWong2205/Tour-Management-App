import 'package:flutter/material.dart';

//Splash screen of the application
class SplashScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Hello there...",
              style: TextStyle(fontSize: 24, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
