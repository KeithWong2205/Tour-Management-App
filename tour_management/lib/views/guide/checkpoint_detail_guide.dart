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
          backgroundColor: Colors.grey[350],
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Checkpoint Details',
              style: TextStyle(fontSize: 24),
            ),
            backgroundColor: Colors.redAccent,
          ),
          body: checkpoint == null
              ? Container()
              : Container(
                  child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Image(
                            image: AssetImage('assets/chekgrad.jpg'),
                            height: MediaQuery.of(context).size.height / 3,
                            fit: BoxFit.fill,
                          ),
                          Positioned(
                            child: Container(
                              height: MediaQuery.of(context).size.height / 3.5,
                              child: checkpoint.pointPhotoUrl != null &&
                                      checkpoint.pointPhotoUrl.isNotEmpty
                                  ? Image.network(checkpoint.pointPhotoUrl,
                                      fit: BoxFit.fill)
                                  : Container(),
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)),
                              width:
                                  MediaQuery.of(context).size.width * (5 / 6),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: MaterialButton(
                              elevation: 10,
                              highlightElevation: 4,
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              minWidth: MediaQuery.of(context).size.width / 3,
                              height: 50,
                              onPressed: () {
                                AppDataHelper.getUser().then((user) {
                                  if (user.role != 'manager') {
                                    String _message =
                                        "S.O.S reported at checkpoint name: " +
                                            checkpoint.pointName;
                                    FCMHelper.sendMessage(
                                        message: _message,
                                        title: checkpoint.pointGroup,
                                        to: '/topics/' + checkpoint.pointGroup);
                                    FCMHelper.sendMessage(
                                        message: _message,
                                        title: checkpoint.pointGroup,
                                        to: '/topics/' +
                                            FCMHelper.MANAGER_CHANNEL);
                                  }
                                });
                              },
                              child: Text(
                                "SOS",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: MaterialButton(
                              elevation: 10,
                              highlightElevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              minWidth: MediaQuery.of(context).size.width / 3,
                              height: 50,
                              disabledColor: Colors.black,
                              disabledTextColor: Colors.grey,
                              disabledElevation: 0,
                              color: Colors.green,
                              onPressed: checkpoint.pointCheckin == true
                                  ? null
                                  : () {
                                      AppDataHelper.getUser().then((user) {
                                        if (user.role != 'manager') {
                                          String _message =
                                              "Checked-in at checkpoint name: " +
                                                  checkpoint.pointName;
                                          FCMHelper.sendMessage(
                                              message: _message,
                                              title: checkpoint.pointGroup,
                                              to: '/topics/' +
                                                  checkpoint.pointGroup);
                                          FCMHelper.sendMessage(
                                              message: _message,
                                              title: checkpoint.pointGroup,
                                              to: '/topics/' +
                                                  FCMHelper.MANAGER_CHANNEL);
                                        }
                                      });
                                      BlocProvider.of<CheckpointManBloc>(
                                              context)
                                          .add(CheckpointManUpdated(checkpoint
                                              .copyWith(checkin: true)));
                                    },
                              child: Text("Check-in",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
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
