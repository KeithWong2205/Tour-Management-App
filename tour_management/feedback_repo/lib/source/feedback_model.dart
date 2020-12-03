import 'package:meta/meta.dart';
import '../feedback_repo.dart';

//Class for the model of the feedback
@immutable
class FeedbackModel {
  final String feedbackID;
  final String checkpointID; //Get from checkpoint, to query to each checkpoint
  final String userID; //Get from user, to see who gives the feedback
  final String userName; //Get from user, to see who gives the feedback
  final double ratingOverall; //star rating score
  final String commentOnGuide;
  final String commentOnTopic;
  final String commentOnSpeaker;
  final String commentOnTourApp;
  final bool subscription;
  FeedbackModel(
      {this.subscription = false,
      String feedbackID,
      String checkpointID,
      String userID,
      String userName,
      String commentOnGuide,
      String commentOnTopic,
      String commentOnSpeaker,
      String commentOnTourApp,
      double ratingOverall})
      : this.feedbackID = feedbackID,
        this.checkpointID = checkpointID,
        this.userID = userID,
        this.userName = userName,
        this.commentOnGuide = commentOnGuide ?? '',
        this.commentOnSpeaker = commentOnSpeaker ?? '',
        this.commentOnTopic = commentOnTopic ?? '',
        this.commentOnTourApp = commentOnTourApp ?? '',
        this.ratingOverall = ratingOverall ?? 1;

  //Passing parameters
  FeedbackModel copyWith({
    bool subscription,
    String feedId,
    String checkId,
    String userId,
    String userName,
    String commentGuide,
    String commentSpeak,
    String commentTopic,
    String commentApp,
    double rating,
  }) {
    return FeedbackModel(
        feedbackID: feedId ?? this.feedbackID,
        checkpointID: checkId ?? this.checkpointID,
        userID: userId ?? this.userID,
        userName: userName ?? this.userName,
        commentOnGuide: commentGuide ?? this.commentOnGuide,
        commentOnSpeaker: commentSpeak ?? this.commentOnSpeaker,
        commentOnTopic: commentTopic ?? this.commentOnTopic,
        commentOnTourApp: commentApp ?? this.commentOnTourApp,
        ratingOverall: rating ?? this.ratingOverall,
        subscription: subscription ?? this.subscription);
  }

//Hashcode and operator
  @override
  int get hashCode =>
      feedbackID.hashCode ^
      checkpointID.hashCode ^
      userID.hashCode ^
      userName.hashCode ^
      commentOnGuide.hashCode ^
      commentOnTopic.hashCode ^
      commentOnSpeaker.hashCode ^
      commentOnTourApp.hashCode ^
      subscription.hashCode ^
      ratingOverall.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedbackModel &&
          runtimeType == other.runtimeType &&
          feedbackID == other.feedbackID &&
          checkpointID == other.checkpointID &&
          userID == other.userID &&
          userName == other.userName &&
          commentOnGuide == other.commentOnGuide &&
          commentOnSpeaker == other.commentOnSpeaker &&
          commentOnTopic == other.commentOnTopic &&
          commentOnTourApp == other.commentOnTourApp &&
          ratingOverall == other.ratingOverall &&
          subscription == other.subscription;

//Map model to entity
  FeedbackEntity toEntity() {
    return FeedbackEntity(
        subscription,
        feedbackID,
        checkpointID,
        userID,
        userName,
        commentOnGuide,
        commentOnSpeaker,
        commentOnTopic,
        commentOnTourApp,
        ratingOverall);
  }

//Get the entity and map to model
  static FeedbackModel fromEntity(FeedbackEntity entity) {
    return FeedbackModel(
        subscription: entity.subscription,
        feedbackID: entity.feedbackID,
        checkpointID: entity.checkpointID,
        userID: entity.userID,
        userName: entity.userName,
        commentOnGuide: entity.commentOnGuide,
        commentOnSpeaker: entity.commentOnSpeaker,
        commentOnTopic: entity.commentOnTopic,
        commentOnTourApp: entity.commentOnTourApp,
        ratingOverall: entity.ratingOverall);
  }
}
