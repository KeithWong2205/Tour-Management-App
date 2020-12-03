import 'package:equatable/equatable.dart';
import 'package:feedback_repo/feedback_repo.dart';

//Event of checkpoint list
abstract class FeedbackListEvent extends Equatable {
  const FeedbackListEvent();
  @override
  List<Object> get props => [];
}

//Update on checkpoint list
class FeedbackListUpdated extends FeedbackListEvent {
  final List<FeedbackModel> feedbackList;
  const FeedbackListUpdated(this.feedbackList);
  @override
  List<Object> get props => [feedbackList];
  @override
  String toString() => 'Feedback List Updated {feedbackList: $feedbackList}';
}
