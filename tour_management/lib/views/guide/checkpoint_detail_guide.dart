import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tour_management/controllers/chpnt_manager/chpnt_man.dart';
import 'package:tour_management/helper/AppDataHelper.dart';
import 'package:tour_management/helper/FCMHelper.dart';
import 'package:tour_management/localization/keys.dart';

class CheckpointDetailSceneGuide extends StatefulWidget {
  final String id;
  final dateFormat = new DateFormat('yyyy-HH-dd HH:mm');

  CheckpointDetailSceneGuide({Key key, @required this.id})
      : super(key: key ?? ArchSampleKeys.checkpointDetailsScene);

  @override
  State<StatefulWidget> createState() {
    return _CheckpointDetailSceneGuideState();
  }
}

class _CheckpointDetailSceneGuideState
    extends State<CheckpointDetailSceneGuide> {
  // ignore: unused_field
  String _photoUrl;

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
          ),
          body: checkpoint == null
              ? Container()
              : Container(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                            height: 250,
                            child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(9),
                                child: Container(
                                  child: checkpoint.pointPhotoUrl != null &&
                                          checkpoint.pointPhotoUrl.isNotEmpty
                                      ? Image.network(checkpoint.pointPhotoUrl,
                                          fit: BoxFit.fill)
                                      : Container(),
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(10)),
                                  width: 450,
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                color: Colors.green,
                                onPressed: () {
                                  AppDataHelper.getUser().then((user) {
                                    if (user.role != 'manager') {
                                      FCMHelper.sendMessage(
                                          message: "Checkpoint");
                                    }
                                  });
                                  BlocProvider.of<CheckpointManBloc>(context)
                                      .add(CheckpointManUpdated(
                                          checkpoint.copyWith(
                                              checkin:
                                                  !checkpoint.pointCheckin)));
                                },
                                child: Text("SOS"),
                              ),
                            ),
                            RaisedButton(
                              onPressed: null,
                              child: Text("Check-in"),
                            )
                          ],
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
                              widget.dateFormat
                                  .format(checkpoint.pointDatetime),
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
        );
      },
    );
  }
}
