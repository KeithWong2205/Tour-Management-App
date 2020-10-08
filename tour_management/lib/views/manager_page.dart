import 'package:chpnt_repo_manager/chpnt_repo_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_management/controllers/chpnt_manager/chpnt_man.dart';
import 'package:tour_management/controllers/chpoint_list/chpoint_list.dart';
import 'package:tour_management/localization/keys.dart';
import 'package:tour_management/views/views.dart';

//Manager side checkpoint management page
class ManagerCheckPointPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) {
          return BlocProvider(
            create: (context) {
              CheckPointListBloc(
                  checkpointManBloc:
                      BlocProvider.of<CheckpointManBloc>(context));
            },
            child: CheckpointListScene(),
          );
        },
        '/addTodo': (context) {
          return AddEditScene(
            key: ArchSampleKeys.addTodoScreen,
            onSave: (name, groupID, location, dateTime, note) {
              BlocProvider.of<CheckpointManBloc>(context).add(
                  CheckpointManAdded(CheckpointModel(name,
                      pointGroup: groupID,
                      pointLocal: location,
                      pointDatetime: dateTime,
                      pointNote: note)));
            },
            isEditing: false,
          );
        }
      },
    );
  }
}
