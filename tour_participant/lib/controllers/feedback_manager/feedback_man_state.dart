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
  String toString() => 'Feedbacks are loading';
}

//Load Success
class FeedbackManLoadSuccess extends FeedbackManState {
  final List<FeedbackModel> fbackLists;
  const FeedbackManLoadSuccess([this.fbackLists = const []]);
  @override
  List<Object> get props => [fbackLists];
  @override
  String toString() => 'Feedbacks loaded {feedbacks: $fbackLists}';
}

//Load Failed
class FeedbackManLoadFail extends FeedbackManState {
  @override
  String toString() => 'Feedbacks failed to load';
}
