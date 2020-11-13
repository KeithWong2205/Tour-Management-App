import 'package:equatable/equatable.dart';
import 'package:tour_management/models/users_repo/users_repo.dart';

//Event of group list
abstract class GroupListEvent extends Equatable {
  const GroupListEvent();
  @override
  List<Object> get props => [];
}

//Update group filter
class FilterUpdated extends GroupListEvent {
  final VisibilityGroupFilter groupFilter;
  const FilterUpdated(this.groupFilter);
  @override
  List<Object> get props => [groupFilter];
  @override
  String toString() => 'Filter selected: $groupFilter';
}

//Update list of group
class GroupListUpdated extends GroupListEvent {
  final List<UserModel> users;
  const GroupListUpdated(this.users);
  @override
  List<Object> get props => [users];
  @override
  String toString() => 'Grouped users loaded with user: $users';
}
