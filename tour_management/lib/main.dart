import 'package:chpnt_repo_manager/chpnt_repo_manager.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_management/controllers/chpnt_manager/chpnt_man.dart';
import 'package:tour_management/controllers/controllers.dart';
import 'package:tour_management/controllers/authentication/auth.dart';
import 'package:tour_management/views/views.dart';
import 'package:tour_management/models/users_repo/users_repo.dart';

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
  final FireBaseService firebaseService = FireBaseService();
  final FirebaseCheckpointService firebaseCheckpointService =
      FirebaseCheckpointService();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) {
        return AuthBloc(firebaseService: firebaseService)..add(AppStarted());
      },
      child: MaterialApp(home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return SplashScene();
          }
          if (state is Authenticated) {
            return BlocProvider(
              create: (context) {
                return CheckpointManBloc(
                    firebaseCheckpointService: firebaseCheckpointService)
                  ..add(CheckpointManLoaded());
              },
              child: HomeTabNavi(),
            );
          }
          return LoginScene(firebaseService: firebaseService);
        },
      )),
    );
  }
}
