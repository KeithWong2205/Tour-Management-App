import 'package:equatable/equatable.dart';
import 'package:tour_participant/models/student_repo/user_model.dart';

//Class for group operation
class GroupManState extends Equatable {
  const GroupManState();
  @override
  List<Object> get props => [];
}

//Loading state
class GroupManLoadin extends GroupManState {
  @override
  String toString() => 'Grouped users are loading';
}

//Loaded success
class GroupManLoadSuccess extends GroupManState {
  final List<UserModel> users;
  const GroupManLoadSuccess([this.users = const []]);
  @override
  List<Object> get props => [users];
  @override
  String toString() => 'Grouped users loaded';
}

//Load failed
class GroupManLoadFail extends GroupManState {
  @override
  String toString() => 'Grouped users load failed';
}
