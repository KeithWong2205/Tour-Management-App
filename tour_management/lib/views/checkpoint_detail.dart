import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tour_management/controllers/chpnt_manager/chpnt_man.dart';
import 'package:tour_management/localization/keys.dart';
import 'package:tour_management/views/add_edit_scene.dart';

class CheckpointDetailScene extends StatelessWidget {
  final String id;
  final dateFormat = new DateFormat('yyyy-HH-dd HH:mm');
  CheckpointDetailScene({Key key, @required this.id})
      : super(key: key ?? ArchSampleKeys.checkpointDetailsScene);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckpointManBloc, CheckpointManState>(
      builder: (context, state) {
        final checkpoint = (state as CheckpointManLoadSuccess)
            .checkpoints
            .firstWhere((checkpoint) => checkpoint.pointId == id,
                orElse: () => null);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Checkpoint Details',
              style: TextStyle(fontSize: 24),
            ),
            backgroundColor: Colors.redAccent,
            actions: [
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  BlocProvider.of<CheckpointManBloc>(context)
                      .add(CheckpointManDelete(checkpoint));
                  Navigator.pop(context);
                },
              )
            ],
          ),
          body: checkpoint == null
              ? Container()
              : Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: 250,
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(9),
                              child: Container(
                                width: 450,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        title: Text(
                          'Checkpoint Name',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 16, color: Colors.redAccent),
                        ),
                        subtitle: Text(
                          checkpoint.pointName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        title: Text(
                          'Attendee Group',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 16, color: Colors.redAccent),
                        ),
                        subtitle: Text(
                          checkpoint.pointGroup,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        title: Text(
                          'Checkpoint Location',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 16, color: Colors.redAccent),
                        ),
                        subtitle: Text(
                          checkpoint.pointLocal,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        title: Text(
                          'Checkpoint Date & Time',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 16, color: Colors.redAccent),
                        ),
                        subtitle: Text(
                          dateFormat.format(checkpoint.pointDatetime),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        title: Text(
                          'Checkpoint Note',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 16, color: Colors.redAccent),
                        ),
                        subtitle: Text(
                          checkpoint.pointNote,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
          floatingActionButton: FloatingActionButton.extended(
              key: ArchSampleKeys.editCheckpointFAB,
              icon: Icon(Icons.edit),
              label: Text('Edit C.Point'),
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              onPressed: checkpoint == null
                  ? null
                  : () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return AddEditScene(
                          key: ArchSampleKeys.editCheckpointScene,
                          onSave: (name, groupID, location, dateTime, note) {
                            BlocProvider.of<CheckpointManBloc>(context).add(
                                CheckpointManUpdated(checkpoint.copyWith(
                                    name: name,
                                    group: groupID,
                                    location: location,
                                    dateTime: dateTime,
                                    note: note)));
                          },
                          isEditing: true,
                          checkpoint: checkpoint,
                        );
                      }));
                    }),
        );
      },
    );
  }
}
