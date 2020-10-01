import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';
import 'package:tour_management/views/views.dart';

//Widget for the forgot password button
class ForgotPassButton extends StatelessWidget {
  final FireBaseService firebaseService;

  ForgotPassButton({Key key, @required this.firebaseService})
      : assert(firebaseService != null),
        super(key: key);

//Building the forgot password button
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black,
      height: 50,
      color: Colors.red,
      textColor: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      onPressed: () =>
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return ResetScene(firebaseService: firebaseService);
      })),
      child: Text(
        'Forgot password',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
