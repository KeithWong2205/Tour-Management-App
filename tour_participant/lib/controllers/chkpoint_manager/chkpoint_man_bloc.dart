import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:chpnt_repo_manager/chpnt_repo_manager.dart';
import 'package:tour_participant/controllers/chkpoint_manager/chkpoint_man.dart';
import 'package:tour_participant/helper/SharedPreferencesHelper.dart';

//Checkpoint business bloc
class CheckpointManBloc extends Bloc<CheckpointManEvent, CheckpointManState> {
  final FirebaseCheckpointService firebaseCheckpointService;
  StreamSubscription _checkpointSubscription;
  CheckpointManBloc({@required this.firebaseCheckpointService})
      : assert(firebaseCheckpointService != null),
        super(CheckpointManLoadin());

//Using stream to map events to states
  @override
  Stream<CheckpointManState> mapEventToState(CheckpointManEvent event) async* {
    if (event is CheckpointManLoaded) {
      var _user = await AppDataHelper.getUser();
      var _groupId = _user.groupID;
      yield* mapCheckpointManLoaded(groupId: _groupId);
    }
    if (event is CheckpointManAdded) {
      yield* mapCheckpointManAdded(event);
    }
    if (event is CheckpointManUpdated) {
      yield* mapCheckpointManUpdated(event);
    }
    if (event is CheckpointManDelete) {
      yield* mapCheckpointManDelete(event);
    }
    if (event is CheckpointListManUpdate) {
      yield* mapCheckpointListManUpdate(event);
    }
  }

  Stream<CheckpointManState> mapCheckpointManLoaded({String groupId}) async* {
    _checkpointSubscription?.cancel();
    _checkpointSubscription = firebaseCheckpointService
        .checkpoints(groupId: groupId)
        .listen((checkpoints) => add(CheckpointListManUpdate(checkpoints)));
  }

  Stream<CheckpointManState> mapCheckpointManAdded(
      CheckpointManAdded event) async* {
    firebaseCheckpointService.addNewCheckpoint(event.checkpoint);
  }

  Stream<CheckpointManState> mapCheckpointManUpdated(
      CheckpointManUpdated event) async* {
    firebaseCheckpointService.updateCheckpoint(event.updated);
  }

  Stream<CheckpointManState> mapCheckpointManDelete(
      CheckpointManDelete event) async* {
    firebaseCheckpointService.deleteCheckpoint(event.deleted);
  }

  Stream<CheckpointManState> mapCheckpointListManUpdate(
      CheckpointListManUpdate event) async* {
    yield CheckpointManLoadSuccess(event.updatedList);

    @override
    // ignore: unused_element
    Future<void> close() {
      _checkpointSubscription?.cancel();
      return super.close();
    }
  }
}
