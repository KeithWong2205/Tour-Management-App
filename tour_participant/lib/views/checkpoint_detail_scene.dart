import 'package:chpnt_repo_manager/chpnt_repo_manager.dart';
import 'package:feedback_repo/feedback_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tour_participant/controllers/chkpoint_manager/chkpoint_man.dart';
import 'package:tour_participant/controllers/feedback_manager/feedback_man.dart';
import 'package:tour_participant/helper/SharedPreferencesHelper.dart';
import 'package:tour_participant/localization/keys.dart';
import 'package:tour_participant/models/student_repo/student_repo.dart';
import 'package:tour_participant/views/feedback_scene.dart';

// ignore: must_be_immutable
class CheckpointDetailScene extends StatelessWidget {
  final String id;
  final dateFormat = new DateFormat('yyyy-HH-dd HH:mm');

  // ignore: avoid_init_to_null
  List<FeedbackModel> feedbackList = null;
  String userId = "";

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
                  feedbackList = state.checkpoints;
                }
              }
              if (feedbackList == null) {
                BlocProvider.of<FeedbackManBloc>(context)
                    .add(FeedbackManLoaded());
              } else {
                for (var index = 0; index < feedbackList.length; index++) {
                  var feedback = feedbackList[index];
                  if (feedback.userID == snapshot.data.id) {
                    disableRateCheckpoint = true;
                  }
                }
              }
              if (disableRateCheckpoint) {
                return RaisedButton(
                  onPressed: null,
                  color: Colors.redAccent,
                  child: Text('Rate checkpoint'),
                );
              }
              return RaisedButton(
                onPressed: () async {
                  var totalRatingStar = await Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => FeedBackScene(this.id)));
                  if (totalRatingStar >= 0) {
                    BlocProvider.of<CheckpointManBloc>(context).add(
                        CheckpointManUpdated(model.copyWith(
                            totalRating: model.totalRating + 1,
                            totalRatingStar:
                                model.totalRatingStar + totalRatingStar)));
                  }
                },
                color: Colors.redAccent,
                child: Text('Rate checkpoint'),
              );
            });
        }
      },
    );
  }
}
