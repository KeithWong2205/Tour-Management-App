import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_participant/controllers/register/register.dart';
import 'package:tour_participant/models/student_repo/student_repo.dart';
import 'package:tour_participant/widgets/widgets.dart';

//Widget for the register scene
class RegisterScene extends StatefulWidget {
  final FirebaseService firebaseService;
  RegisterScene({Key key, @required this.firebaseService})
      : assert(firebaseService != null),
        super(key: key);
  State<RegisterScene> createState() => _RegisterSceneState();
}

class _RegisterSceneState extends State<RegisterScene> {
  RegBloc _regBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: BlocProvider<RegBloc>(
          create: (context) => RegBloc(firebaseService: widget.firebaseService),
          child: RegisterForm(),
        ));
  }

  @override
  void dispose() {
    _regBloc.close();
    super.dispose();
  }
}
