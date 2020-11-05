import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tour_management/controllers/chpnt_manager/chpnt_man.dart';
import 'package:tour_management/localization/keys.dart';
import 'package:tour_management/views/views.dart';

class CheckpointDetailSceneManager extends StatefulWidget {
  final String id;
  final dateFormat = new DateFormat('yyyy-HH-dd HH:mm');

  CheckpointDetailSceneManager({Key key, @required this.id})
      : super(key: key ?? ArchSampleKeys.checkpointDetailsScene);

  @override
  State<StatefulWidget> createState() {
    return _CheckpointDetailSceneManagerState();
  }
}

class _CheckpointDetailSceneManagerState extends State<CheckpointDetailSceneManager> {

  File _imageSelected;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckpointManBloc, CheckpointManState>(
      builder: (context, state) {
        final checkpoint = (state as CheckpointManLoadSuccess)
            .checkpoints
            .firstWhere((checkpoint) => checkpoint.pointId == widget.id,
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
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                          height: 250,
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(9),
                              child: Container(
                                child: _imageSelected != null ? Image.file(_imageSelected) : Container(),
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                width: 450,
                              ),
                            ),
                          )
                      ),
                      onTap: getImage,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RatingBarIndicator(
                      rating: 4,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 50,
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.announcement,
                          color: Colors.redAccent,
                        ),
                        title: Text(
                          'Checkpoint Name',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, color: Colors.redAccent),
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
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.group,
                          color: Colors.redAccent,
                        ),
                        title: Text(
                          'Attendee Group',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, color: Colors.redAccent),
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
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.add_location,
                          color: Colors.redAccent,
                        ),
                        title: Text(
                          'Location',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, color: Colors.redAccent),
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
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.calendar_today,
                          color: Colors.redAccent,
                        ),
                        title: Text(
                          'Date & Time',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, color: Colors.redAccent),
                        ),
                        subtitle: Text(
                          widget.dateFormat.format(checkpoint.pointDatetime),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.event_note,
                          color: Colors.redAccent,
                        ),
                        title: Text(
                          'Note',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, color: Colors.redAccent),
                        ),
                        subtitle: Text(
                          checkpoint.pointNote,
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              )),
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

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageSelected = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
