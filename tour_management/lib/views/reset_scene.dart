import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_management/controllers/reset/reset.dart';
import 'package:user_repository/user_repository.dart';
import 'package:tour_management/widgets/widgets.dart';

//Widget for the reset password scene
class ResetScene extends StatefulWidget {
  final FireBaseService firebaseService;
  ResetScene({Key key, @required this.firebaseService})
      : assert(firebaseService != null),
        super(key: key);
  State<ResetScene> createState() => _ResetSceneState();
}

class _ResetSceneState extends State<ResetScene> {
  ResetBloc _resetBloc;

//Building the widget for the scene
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: missing_required_param
      body: BlocProvider<ResetBloc>(
        create: (context) {
          return ResetBloc(firebaseService: widget.firebaseService);
        },
        child: ResetForm(),
      ),
    );
  }

  @override
  void dispose() {
    _resetBloc.close();
    super.dispose();
  }
}
