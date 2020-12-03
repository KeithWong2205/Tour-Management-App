import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

//Class for feedback entity
class FeedbackEntity extends Equatable {
  final bool subscription;
  final String feedbackID;
  final String checkpointID;
  final String userID;
  final String userName;
  final String commentOnGuide;
  final String commentOnTopic;
  final String commentOnSpeaker;
  final String commentOnTourApp;
  final double ratingOverall;
  const FeedbackEntity(
      this.subscription,
      this.feedbackID,
      this.checkpointID,
      this.userID,
      this.userName,
      this.commentOnGuide,
      this.commentOnSpeaker,
      this.commentOnTopic,
      this.commentOnTourApp,
      this.ratingOverall);
  @override
  List<Object> get props => [
        subscription,
        feedbackID,
        checkpointID,
        userID,
        userName,
        commentOnGuide,
        commentOnSpeaker,
        commentOnTopic,
        commentOnTourApp,
        ratingOverall
      ];

//Map Entity to Json
  Map<String, Object> toJson() {
    return {
      'feedbackID': feedbackID,
      'checkpointID': checkpointID,
      'userID': userID,
      'userName': userName,
      'GuideFeedback': commentOnGuide,
      'TopicFeedback': commentOnTopic,
      'SpeakerFeedback': commentOnSpeaker,
      'AppFeedback': commentOnTourApp,
      'Subscribe?': subscription,
      'RatingScore': ratingOverall,
    };
  }

//Map Entity from Json
  static FeedbackEntity fromJson(Map<String, Object> json) {
    return FeedbackEntity(
        json['Subscribe?'] as bool,
        json['feedbackID'] as String,
        json['checkpointID'] as String,
        json['userID'] as String,
        json['userName'] as String,
        json['GuideFeedback'] as String,
        json['TopicFeedback'] as String,
        json['SpeakerFeedback'] as String,
        json['AppFeedback'] as String,
        json['RatingScore'] as double);
  }

//Map Entity from snapshot
  static FeedbackEntity fromSnapshot(DocumentSnapshot snapshot) {
    return FeedbackEntity(
        snapshot.data()['subscription'],
        snapshot.id,
        snapshot.data()['checkpointID'],
        snapshot.data()['userID'],
        snapshot.data()['userName'],
        snapshot.data()['GuideFeedback'],
        snapshot.data()['TopicFeedback'],
        snapshot.data()['SpeakerFeedback'],
        snapshot.data()['AppFeedback'],
        snapshot.data()['RatingScore']);
  }

  //Map entity to firestore document
  Map<String, Object> toDocument() {
    return {
      'subscription': subscription,
      'feedbackID': feedbackID,
      'checkpointID': checkpointID,
      'userID': userID,
      'userName': userName,
      'GuideFeedback': commentOnGuide,
      'TopicFeedback': commentOnTopic,
      'SpeakerFeedback': commentOnSpeaker,
      'AppFeedback': commentOnTourApp,
      'RatingScore': ratingOverall
    };
  }
}
