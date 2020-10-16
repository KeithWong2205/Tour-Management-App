import 'package:equatable/equatable.dart';
import 'package:group_repo/group_repo.dart';

//State of group operations
class GroupManState extends Equatable {
  const GroupManState();
  @override
  List<Object> get props => [];
}

//Loading state
class GroupManLoadin extends GroupManState {
  @override
  String toString() => 'Groups loading';
}

//Loaded state
class GroupManLoadSuccess extends GroupManState {
  final List<GroupModel> groups;
  const GroupManLoadSuccess([this.groups = const []]);
  @override
  List<Object> get props => [groups];
  @override
  String toString() => 'Groups loaded {groups : $groups}';
}

//Load fail
class GroupManLoadFail extends GroupManState {
  @override
  String toString() => 'Group failed to load';
}
