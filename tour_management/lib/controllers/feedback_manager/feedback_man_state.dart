import 'package:equatable/equatable.dart';
import 'package:feedback_repo/feedback_repo.dart';

//Class for states of checkpoint operations
class FeedbackManState extends Equatable {
  const FeedbackManState();
  @override
  List<Object> get props => [];
}

//Loading state
class FeedbackManLoading extends FeedbackManState {
  @override
  String toString() => 'Checkpoints are loading';
}

//Load Success
class FeedbackManLoadSuccess extends FeedbackManState {
  final List<FeedbackModel> feedbackList;
  const FeedbackManLoadSuccess([this.feedbackList = const []]);
  @override
  List<Object> get props => [feedbackList];
  @override
  String toString() => 'Feedback loaded {feedbackList: $feedbackList}';
}

//Load Failed
class FeedbackManLoadFail extends FeedbackManState {
  @override
  String toString() => 'Feedback list failed to load';
}
