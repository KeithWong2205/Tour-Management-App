import 'package:equatable/equatable.dart';
import 'package:tour_management/models/users_repo/users_repo.dart';

//State of the group list
abstract class GroupListState extends Equatable {
  const GroupListState();
  @override
  List<Object> get props => [];
}

//Loading
class GroupListLoadin extends GroupListState {
  @override
  String toString() => 'List of groups loading';
}

//Loaded
class GroupListLoaded extends GroupListState {
  final List<UserModel> users;
  final VisibilityGroupFilter groupFilter;
  const GroupListLoaded(this.users, this.groupFilter);
  @override
  List<Object> get props => [users, groupFilter];
  @override
  String toString() =>
      'User groups loaded : users $users and filter: $groupFilter';
}
