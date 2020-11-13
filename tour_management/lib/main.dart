import 'package:chpnt_repo_manager/chpnt_repo_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_management/controllers/chpnt_manager/chpnt_man.dart';
import 'package:tour_management/controllers/chpoint_list/chpoint_list.dart';
import 'package:tour_management/controllers/controllers.dart';
import 'package:tour_management/controllers/authentication/auth.dart';
import 'package:tour_management/controllers/group_list/group_list.dart';
import 'package:tour_management/controllers/group_manager/group_man_bloc.dart';
import 'package:tour_management/controllers/group_manager/group_man_event.dart';
import 'package:tour_management/views/views.dart';
import 'package:tour_management/models/users_repo/users_repo.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    // final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    // final dynamic notification = message['notification'];
  }

  // Or do other work.
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
  final FireStoreService userFireStoreService = FireStoreService();
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
                      BlocProvider.of<CheckpointManBloc>(context))),
          BlocProvider<GroupManBloc>(
              create: (context) =>
                  GroupManBloc(userFirestoreService: userFireStoreService)
                    ..add(GroupManLoaded())),
          BlocProvider<GroupListBloc>(
            create: (context) => GroupListBloc(
                groupManBloc: BlocProvider.of<GroupManBloc>(context)),
          )
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
          '/addTodo': (context) {
            return AddEditScene(
              isEditing: false,
              onSave: (name, groupID, location, dateTime, note, photoUrl) {
                BlocProvider.of<CheckpointManBloc>(context).add(
                    CheckpointManAdded(CheckpointModel(name,
                        pointGroup: groupID,
                        pointLocal: location,
                        pointDatetime: dateTime,
                        pointNote: note,
                        pointPhotoUrl: "")));
              },
            );
          }
        }));
  }
}
