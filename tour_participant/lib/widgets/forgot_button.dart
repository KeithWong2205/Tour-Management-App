import 'package:flutter/material.dart';
import 'package:tour_participant/models/student_repo/student_repo.dart';
import 'package:tour_participant/views/views.dart';

//Widget for the forgot password button
class ForgotPassButton extends StatelessWidget {
  final FirebaseService firebaseService;

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
      color: Colors.white,
      textColor: Colors.red,
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
