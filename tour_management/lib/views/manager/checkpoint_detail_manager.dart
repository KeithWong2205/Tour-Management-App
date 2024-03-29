import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:tour_management/controllers/chpnt_manager/chpnt_man.dart';
import 'package:tour_management/localization/keys.dart';
import 'package:tour_management/styles/animation.dart';
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

class _CheckpointDetailSceneManagerState
    extends State<CheckpointDetailSceneManager> {
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
                                height:
                                    MediaQuery.of(context).size.height / 3.5,
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
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                child: RatingBarIndicator(
                                  rating: (checkpoint.totalRatingStar /
                                              checkpoint.totalRating) ==
                                          null
                                      ? 0
                                      : (checkpoint.totalRatingStar /
                                          checkpoint.totalRating),
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 50,
                                )),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 10,
                                  highlightElevation: 4,
                                  height: 45,
                                  minWidth:
                                      MediaQuery.of(context).size.width / 3,
                                  color: Colors.amber,
                                  textColor: Colors.white,
                                  onPressed: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              FeedBackCollectionScene())),
                                  child: Text('View feedback',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black)),
                                )),
                          ],
                        ),
                        SizedBox(height: 20),
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
                label: Text('Edit'),
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                onPressed: checkpoint == null
                    ? null
                    : () {
                        Navigator.push(
                            context,
                            SlideTopRoute(
                                page: AddEditScene(
                              key: ArchSampleKeys.editCheckpointScene,
                              onSave: (name, groupID, location, dateTime, note,
                                  photoUrl) {
                                BlocProvider.of<CheckpointManBloc>(context).add(
                                    CheckpointManUpdated(checkpoint.copyWith(
                                        name: name,
                                        group: groupID,
                                        location: location,
                                        dateTime: dateTime,
                                        note: note,
                                        photoUrl: photoUrl)));
                              },
                              isEditing: true,
                              checkpoint: checkpoint,
                            )));
                      }));
      },
    );
  }
}
