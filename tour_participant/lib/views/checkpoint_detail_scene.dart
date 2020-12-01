import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tour_participant/controllers/chkpoint_manager/chkpoint_man.dart';
import 'package:tour_participant/localization/keys.dart';
import 'package:tour_participant/views/feedback_scene.dart';

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
                              dateFormat.format(checkpoint.pointDatetime),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                onPressed: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => FeedBackScene(this.id))),
                                color: Colors.redAccent,
                                child: Text('Rate checkpoint'),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8),
                                child: RaisedButton(
                                  onPressed: null,
                                  color: Colors.redAccent,
                                  child: Text('View More Info'),
                                ))
                          ],
                        )
                      ],
                    ),
                  )),
        );
      },
    );
  }
}
