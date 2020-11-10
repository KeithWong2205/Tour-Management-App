import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tour_management/models/users_repo/users_repo.dart';
import 'package:tour_management/controllers/group_manager/group_man.dart';
import 'package:tour_management/helper/AppDataHelper.dart';

//Group business bloc
class GroupManBloc extends Bloc<GroupManEvent, GroupManState> {
  final FireStoreService userFirestoreService;
  StreamSubscription _userSubscription;
  GroupManBloc({@required this.userFirestoreService})
      : assert(userFirestoreService != null),
        super(GroupManLoadin());

  //Mapping the event to the state
  @override
  Stream<GroupManState> mapEventToState(GroupManEvent event) async* {
    if (event is GroupManLoaded) {
      var _user = await AppDataHelper.getUser();
      var _groupId = '';
      if (_user.role == 'guide') {
        _groupId = _user.groupID;
      }
      yield* _mapGroupManLoaded(groupId: _groupId);
    }
    if (event is GroupManListUpdates) {
      yield* _mapGroupManListUpdated(event);
    }
  }

  Stream<GroupManState> _mapGroupManLoaded({String groupId}) async* {
    _userSubscription?.cancel();
    _userSubscription = userFirestoreService
        .users(groupId: groupId)
        .listen((users) => add(GroupManListUpdates(users)));
  }

  Stream<GroupManState> _mapGroupManListUpdated(
      GroupManListUpdates event) async* {
    yield GroupManLoadSuccess(event.userLists);
  }

  @override
  // ignore: unused_element
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
