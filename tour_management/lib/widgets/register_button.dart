import 'package:flutter/material.dart';
import 'package:tour_management/models/users_repo/users_repo.dart';
import 'package:tour_management/views/views.dart';

//Widget of the register button
class RegisterButton extends StatelessWidget {
  final FireBaseService firebaseService;
  RegisterButton({Key key, @required this.firebaseService})
      : assert(firebaseService != null),
        super(key: key);

  //Building the widget for the register button
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        'Sign-up here!',
        style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.blue,
            fontSize: 16),
      ),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return RegisterScene(firebaseService: firebaseService);
        }));
      },
    );
  }
}
