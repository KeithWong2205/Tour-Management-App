import 'package:equatable/equatable.dart';

import 'package:feedback_repo/feedback_repo.dart';

//Class for events on checkpoint operations
class FeedbackManEvent extends Equatable {
  const FeedbackManEvent();
  @override
  List<Object> get props => [];
}

//Event on load success
class FeedbackManLoaded extends FeedbackManEvent {
  @override
  String toString() => 'Feedback loaded';
}

//Event on add checkpoint
class FeedbackManAdded extends FeedbackManEvent {
  final FeedbackModel feedback;
  const FeedbackManAdded(this.feedback);
  @override
  List<Object> get props => [feedback];
}

//Event on update or edit checkpoint
class FeedbackManUpdated extends FeedbackManEvent {
  final FeedbackModel updated;
  const FeedbackManUpdated(this.updated);
  @override
  List<Object> get props => [updated];
}

//Event on delete checkpoint
class FeedbackManDelete extends FeedbackManEvent {
  final FeedbackModel deleted;
  const FeedbackManDelete(this.deleted);
  @override
  List<Object> get props => [deleted];
}

//Event on update list of checkpoints
class FeedbackListManUpdate extends FeedbackManEvent {
  final List<FeedbackModel> updatedList;
  const FeedbackListManUpdate(this.updatedList);
  @override
  List<Object> get props => [updatedList];
}
