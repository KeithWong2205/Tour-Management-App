import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tour_participant/controllers/feedback_manager/feedback_man.dart';
import 'package:tour_participant/controllers/feedback_manager/feedback_man_bloc.dart';
import 'package:tour_participant/controllers/feedback_manager/feedback_man_state.dart';
import 'package:tour_participant/styles/styles.dart';

import 'package:feedback_repo/feedback_repo.dart';

import '../helper/SharedPreferencesHelper.dart';

class FeedBackForm extends StatefulWidget {
  final String checkpointId;

  FeedBackForm(this.checkpointId);

  @override
  _FeedBackFormState createState() => _FeedBackFormState();
}

class _FeedBackFormState extends State<FeedBackForm> {
  IconData _selectedIcon;
  double _rating;
  bool tapped = false;
  TextEditingController _guideCommentController = TextEditingController();
  TextEditingController _topicCommentController = TextEditingController();
  TextEditingController _speakerCommentController = TextEditingController();
  TextEditingController _appCommentController = TextEditingController();
  FocusNode topicFocus;
  FocusNode speaker;
  FocusNode app;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedbackManBloc, FeedbackManState>(
        builder: (context, state) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Form(
              child: Center(
            child: ListView(
              children: [
                SizedBox(height: 10),
                Text(
                  'Checkpoint Evaluation Form',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Container(
                  color: Colors.red,
                  height: 5,
                  width: MediaQuery.of(context).size.width,
                ),
                SizedBox(height: 15),
                Text(
                  'Overall rating for the checkpoint',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    alignment: Alignment.center,
                    height: 70,
                    color: Colors.blue[100].withOpacity(0.3),
                    child: _ratingBar(),
                    width: MediaQuery.of(context).size.width),
                SizedBox(height: 15),
                Text(
                  'Do you have any comments on the guides',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: feedbackFormFieldStyle(),
                  controller: _guideCommentController,
                  textInputAction: TextInputAction.next,
                  maxLines: 5,
                  validator: (val) {
                    return val.trim().isEmpty
                        ? 'Please give your thoughts'
                        : null;
                  },
                  onFieldSubmitted: (val) =>
                      FocusScope.of(context).requestFocus(topicFocus),
                ),
                SizedBox(height: 15),
                Text(
                  'Do you have any comments on the topic of this checkpoint?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: feedbackFormFieldStyle(),
                  controller: _topicCommentController,
                  textInputAction: TextInputAction.next,
                  maxLines: 5,
                  validator: (val) {
                    return val.trim().isEmpty
                        ? 'Please give your thoughts'
                        : null;
                  },
                  onFieldSubmitted: (val) =>
                      FocusScope.of(context).requestFocus(speaker),
                ),
                SizedBox(height: 15),
                Text(
                  'Do you have any comments on the speaker of this checkpoint',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: feedbackFormFieldStyle(),
                  controller: _speakerCommentController,
                  textInputAction: TextInputAction.next,
                  maxLines: 5,
                  validator: (val) {
                    return val.trim().isEmpty
                        ? 'Please give your thoughts'
                        : null;
                  },
                  onFieldSubmitted: (val) =>
                      FocusScope.of(context).requestFocus(app),
                ),
                SizedBox(height: 15),
                Text(
                  'Do you have any comments for the app to improve',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: feedbackFormFieldStyle(),
                  controller: _appCommentController,
                  textInputAction: TextInputAction.next,
                  maxLines: 5,
                  validator: (val) {
                    return val.trim().isEmpty
                        ? 'Please give your thoughts'
                        : null;
                  },
                  onFieldSubmitted: (val) =>
                      FocusScope.of(context).requestFocus(new FocusNode()),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Text(
                    "Would you like to share your information with us? ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text("Please check if you would.",
                      textAlign: TextAlign.center),
                  trailing: Checkbox(
                    value: tapped,
                    onChanged: (value) {
                      setState(() {
                        tapped = value;
                      });
                    },
                  ),
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  color: Colors.amber,
                  onPressed: () {
                    AppDataHelper.getUser().then((user) {
                      BlocProvider.of<FeedbackManBloc>(context).add(
                          FeedbackManAdded(FeedbackModel(
                              checkpointID: widget.checkpointId,
                              userID: user.id,
                              userName: user.name,
                              subscription: tapped,
                              commentOnGuide: _guideCommentController.text,
                              commentOnTopic: _topicCommentController.text,
                              commentOnSpeaker: _speakerCommentController.text,
                              commentOnTourApp: _appCommentController.text,
                              ratingOverall: _rating)));
                      Navigator.pop(context, _rating);
                    });
                  },
                  child: Text('Submit Form'),
                )
              ],
            ),
          )),
        ),
      );
    });
  }

  Widget _ratingBar() {
    return RatingBar.builder(
      initialRating: 0,
      minRating: 0,
      maxRating: 5,
      direction: Axis.horizontal,
      allowHalfRating: true,
      unratedColor: Colors.amber.withAlpha(70),
      itemCount: 5,
      itemSize: 50.0,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) =>
          Icon(_selectedIcon ?? Icons.star, color: Colors.amber),
      onRatingUpdate: (rating) {
        setState(() {
          _rating = rating;
        });
      },
      updateOnDrag: true,
    );
  }
}
