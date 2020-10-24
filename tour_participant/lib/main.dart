import 'package:chpnt_repo_manager/chpnt_repo_manager.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_participant/controllers/chkpoint_manager/chkpoint_man.dart';
import 'package:tour_participant/controllers/chkpoint_list/chkpoint_list.dart';
import 'package:tour_participant/controllers/controllers.dart';
import 'package:tour_participant/controllers/authentication/auth.dart';
import 'package:tour_participant/views/views.dart';
import 'package:tour_participant/models/student_repo/student_repo.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(App());
}

//Widget for the main app
class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final FirebaseService firebaseService = FirebaseService();
  final FirebaseCheckpointService firebaseCheckpointService =
      FirebaseCheckpointService();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
              create: (context) => AuthBloc(firebaseService: firebaseService)
                ..add(AppStarted())),
          BlocProvider<CheckpointManBloc>(
              create: (context) => CheckpointManBloc(
                  firebaseCheckpointService: firebaseCheckpointService)
                ..add(CheckpointManLoaded())),
          BlocProvider<CheckPointListBloc>(
              create: (context) => CheckPointListBloc(
                  checkpointManBloc:
                      BlocProvider.of<CheckpointManBloc>(context)))
        ],
        child: MaterialApp(debugShowCheckedModeBanner: false, routes: {
          '/': (context) {
            return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
              if (state is Uninitialized) {
                return SplashScene();
              }
              if (state is Authenticated) {
                return HomeTabNavi();
              }
              return LoginScene(firebaseService: firebaseService);
            });
          },
        }));
  }
}
