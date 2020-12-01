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
  final List<FeedbackModel> checkpoints;
  const FeedbackManLoadSuccess([this.checkpoints = const []]);
  @override
  List<Object> get props => [checkpoints];
  @override
  String toString() => 'Checkpoints loaded {checkpoints: $checkpoints}';
}

//Load Failed
class FeedbackManLoadFail extends FeedbackManState {
  @override
  String toString() => 'Checkpoints failed to load';
}
