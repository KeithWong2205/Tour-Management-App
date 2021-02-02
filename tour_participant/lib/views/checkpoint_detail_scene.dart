import 'package:chpnt_repo_manager/chpnt_repo_manager.dart';
import 'package:feedback_repo/feedback_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:tour_participant/controllers/chkpoint_manager/chkpoint_man.dart';
import 'package:tour_participant/controllers/feedback_manager/feedback_man.dart';
import 'package:tour_participant/helper/SharedPreferencesHelper.dart';
import 'package:tour_participant/localization/keys.dart';
import 'package:tour_participant/models/student_repo/student_repo.dart';
import 'package:tour_participant/styles/animation.dart';
import 'package:tour_participant/views/feedback_scene.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class CheckpointDetailScene extends StatefulWidget {
  final String id;
  CheckpointDetailScene({Key key, @required this.id})
      : super(key: key ?? ArchSampleKeys.checkpointDetailsScene);

  @override
  _CheckpointDetailSceneState createState() => _CheckpointDetailSceneState();
}

class _CheckpointDetailSceneState extends State<CheckpointDetailScene> {
  String result = "Please scan the QR code or Barcode";
  // ignore: avoid_init_to_null
  List<FeedbackModel> feedbackList = null;
  final dateFormat = new DateFormat('yyyy-HH-dd HH:mm');
  String userId = "";
  String _result;

  checkingValue() {
    if (_result != null || _result != "") {
      if (_result.contains("https") || _result.contains("http")) {
        return _launchURL(_result);
      } else {
        Fluttertoast.showToast(
            msg: "Invalide URL",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      return null;
    }
  }

  _launchURL(String urlQRCode) async {
    String url = urlQRCode;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future _scan() async {
    await Permission.camera.request();
    String barcode = await scanner.scan();
    if (barcode == null) {
      print('nothing return.');
    } else {
      setState(() {
        _result = barcode;
      });
      checkingValue();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckpointManBloc, CheckpointManState>(
      builder: (context, state) {
        final checkpoint = (state as CheckpointManLoadSuccess)
            .checkpoints
            .firstWhere((checkpoint) => checkpoint.pointId == widget.id,
                orElse: () => null);
        return Scaffold(
          backgroundColor: Colors.red[50],
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
                              height: 300,
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
                          )
                        ],
                      ),
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
                            child: buildRateCheckpointButton(
                                context: context, model: checkpoint),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8),
                              child: RaisedButton(
                                onPressed: () => _scan(),
                                color: Colors.blue,
                                child: Text('QR Scanner'),
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

  Widget buildRateCheckpointButton(
      {BuildContext context, CheckpointModel model}) {
    return FutureBuilder<UserModel>(
      future: AppDataHelper.getUser(),
      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Container();
          default:
            return BlocBuilder<FeedbackManBloc, FeedbackManState>(
                builder: (context, state) {
              var disableRateCheckpoint = false;
              if (state is FeedbackManLoadSuccess) {
                if (state.props.isEmpty) {
                  feedbackList = List();
                } else {
                  feedbackList = state.fbackLists;
                }
              }
              if (feedbackList == null) {
                BlocProvider.of<FeedbackManBloc>(context)
                    .add(FeedbackManLoaded());
              } else {
                for (var index = 0; index < feedbackList.length; index++) {
                  var feedback = feedbackList[index];
                  if (feedback.userID == snapshot.data.id &&
                      feedback.checkpointID == widget.id) {
                    disableRateCheckpoint = true;
                  }
                }
              }
              if (disableRateCheckpoint) {
                return RaisedButton(
                  onPressed: null,
                  color: Colors.amber,
                  child: Text('Rate checkpoint'),
                );
              }
              return RaisedButton(
                onPressed: () async {
                  var totalRatingStar = await Navigator.push(
                      context, SlideTopRoute(page: FeedBackScene(widget.id)));
                  if (totalRatingStar >= 0) {
                    BlocProvider.of<CheckpointManBloc>(context).add(
                        CheckpointManUpdated(model.copyWith(
                            totalRating: model.totalRating + 1,
                            totalRatingStar:
                                model.totalRatingStar + totalRatingStar)));
                  }
                },
                color: Colors.amber,
                child: Text('Rate checkpoint'),
              );
            });
        }
      },
    );
  }
}
