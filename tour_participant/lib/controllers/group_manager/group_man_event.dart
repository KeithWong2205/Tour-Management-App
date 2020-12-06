import 'package:equatable/equatable.dart';
import 'package:tour_participant/models/student_repo/user_model.dart';

//Class for events on group operation
class GroupManEvent extends Equatable {
  const GroupManEvent();
  @override
  List<Object> get props => [];
}

//Event on load success
class GroupManLoaded extends GroupManEvent {
  @override
  String toString() => 'Groups loaded';
}

//Update list
class GroupManListUpdates extends GroupManEvent {
  final List<UserModel> userLists;
  const GroupManListUpdates(this.userLists);
  @override
  List<Object> get props => [userLists];
}
