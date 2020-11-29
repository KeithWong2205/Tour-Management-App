import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tour_participant/styles/styles.dart';

class FeedBackForm extends StatefulWidget {
  @override
  _FeedBackFormState createState() => _FeedBackFormState();
}

class _FeedBackFormState extends State<FeedBackForm> {
  IconData _selectedIcon;
  double _rating;
  String _guideCom;
  String _topicCom;
  String _speakerCom;
  String _appCom;
  TextEditingController _guideCommentController;
  TextEditingController _topicCommentController;
  TextEditingController _speakerCommentController;
  TextEditingController _appCommentController;
  FocusNode topicFocus;
  FocusNode speaker;
  FocusNode app;
  @override
  Widget build(BuildContext context) {
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
              Center(child: _ratingBar()),
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
                onSaved: (value) => _guideCom = value,
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
                onSaved: (value) => _topicCom = value,
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
                onSaved: (value) => _speakerCom = value,
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
                onSaved: (value) => _appCom = value,
                onFieldSubmitted: (val) =>
                    FocusScope.of(context).requestFocus(new FocusNode()),
              ),
              RaisedButton(
                onPressed: null,
                child: Text('Submit Form'),
              )
            ],
          ),
        )),
      ),
    );
  }

  Widget _ratingBar() {
    return RatingBar.builder(
      initialRating: 0,
      minRating: 0,
      maxRating: 5,
      direction: Axis.horizontal,
      allowHalfRating: true,
      unratedColor: Colors.amber.withAlpha(50),
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
