import 'package:equatable/equatable.dart';
import 'package:feedback_repo/feedback_repo.dart';

//State of checkpoint list
abstract class FeedbackListState extends Equatable {
  const FeedbackListState();
  @override
  List<Object> get props => [];
}

//Loading
class FeedbackListLoading extends FeedbackListState {
  @override
  String toString() => 'CheckPointList Loading';
}

//Loaded
class FeedbackListLoaded extends FeedbackListState {
  final List<FeedbackModel> feedbackList;
  const FeedbackListLoaded(this.feedbackList);
  @override
  List<Object> get props => [feedbackList];
  @override
  String toString() =>
      'Feedback List Loaded {feedbackList: $feedbackList}';
}
