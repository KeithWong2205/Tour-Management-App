import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tour_management/controllers/group_manager/group_man.dart';
import 'package:tour_management/models/users_repo/users_repo.dart';
import 'package:tour_management/controllers/group_list/group_list.dart';

class GroupListBloc extends Bloc<GroupListEvent, GroupListState> {
  final GroupManBloc groupManBloc;
  StreamSubscription userSubscription;
  GroupListBloc({@required this.groupManBloc})
      : super(groupManBloc.state is GroupManLoadSuccess
            ? GroupListLoaded((groupManBloc.state as GroupManLoadSuccess).users,
                VisibilityGroupFilter.all)
            : GroupListLoadin()) {
    userSubscription = groupManBloc.listen((state) {
      if (state is GroupManLoadSuccess) {
        add(GroupListUpdated(
            (groupManBloc.state as GroupManLoadSuccess).users));
      }
    });
  }

  @override
  Stream<GroupListState> mapEventToState(GroupListEvent event) async* {
    if (event is FilterUpdated) {
      yield* _mapFilterUpdated(event);
    }
    if (event is GroupListUpdated) {
      yield* _mapGroupListUpdated(event);
    }
  }

  //Mapping the filter update event
  Stream<GroupListState> _mapFilterUpdated(FilterUpdated event) async* {
    if (groupManBloc.state is GroupManLoadSuccess) {
      yield GroupListLoaded(
          _mapUsersToFilter((groupManBloc.state as GroupManLoadSuccess).users,
              event.groupFilter),
          event.groupFilter);
    }
  }

  //Mapping the users loaded event
  Stream<GroupListState> _mapGroupListUpdated(GroupListUpdated event) async* {
    final activeFilter = state is GroupListLoaded
        ? (state as GroupListLoaded).groupFilter
        : VisibilityGroupFilter.all;
    yield GroupListLoaded(
        _mapUsersToFilter(
            (groupManBloc.state as GroupManLoadSuccess).users, activeFilter),
        activeFilter);
  }

  List<UserModel> _mapUsersToFilter(
      List<UserModel> users, VisibilityGroupFilter filter) {
    return users.where((user) {
      if (filter == VisibilityGroupFilter.all) {
        return true;
      } else if (filter == VisibilityGroupFilter.guide) {
        return user.role == 'guide';
      } else {
        return user.role == 'student';
      }
    }).toList();
  }

  @override
  Future<void> close() {
    userSubscription?.cancel();
    return super.close();
  }
}
