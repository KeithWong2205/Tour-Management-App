import 'package:equatable/equatable.dart';
import 'package:tour_management/models/users_repo/users_repo.dart';

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
