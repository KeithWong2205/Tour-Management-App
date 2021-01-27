import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_management/models/users_repo/users_repo.dart';
import 'package:tour_management/controllers/login/login.dart';
import 'package:tour_management/widgets/widgets.dart';

//Login screen of the application
class LoginScene extends StatefulWidget {
  final FireBaseService firebaseService;
  LoginScene({Key key, @required this.firebaseService})
      : assert(firebaseService != null),
        super(key: key);
  State<LoginScene> createState() => _LoginSceneState();
}

class _LoginSceneState extends State<LoginScene> {
  LoginBloc _loginBloc;

//Initial state of login scene

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: missing_required_param
      body: BlocProvider<LoginBloc>(
        create: (context) {
          return LoginBloc(firebaseService: widget.firebaseService);
        },
        child: LoginForm(firebaseService: widget.firebaseService),
      ),
    );
  }

  @override
  void dispose() {
    if(_loginBloc != null) {
      _loginBloc.close();
    }
    super.dispose();
  }
}
