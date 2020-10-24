import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:chpnt_repo_manager/chpnt_repo_manager.dart';
import 'package:tour_participant/controllers/chkpoint_manager/chkpoint_man.dart';
import 'package:tour_participant/controllers/chkpoint_list/chkpoint_list.dart';

//Business bloc for checkpoint list
class CheckPointListBloc
    extends Bloc<CheckPointListEvent, CheckPointListState> {
  final CheckpointManBloc checkpointManBloc;
  StreamSubscription checkpointSubscription;
  CheckPointListBloc({@required this.checkpointManBloc})
      : super(checkpointManBloc.state is CheckpointManLoadSuccess
            ? CheckPointListLoaded(
                (checkpointManBloc.state as CheckpointManLoadSuccess)
                    .checkpoints,
                VisibilityFilter.all)
            : CheckPointListLoadin()) {
    checkpointSubscription = checkpointManBloc.listen((state) {
      if (state is CheckpointManLoadSuccess) {
        add(CheckPointListUpdated(
            (checkpointManBloc.state as CheckpointManLoadSuccess).checkpoints));
      }
    });
  }

  @override
  Stream<CheckPointListState> mapEventToState(
      CheckPointListEvent event) async* {
    if (event is CheckPointListUpdated) {
      yield* _mapCheckPointListUpdated(event);
    }
  }

  Stream<CheckPointListState> _mapCheckPointListUpdated(
      CheckPointListUpdated event) async* {
    final visisbilityFilter = state is CheckPointListLoaded
        ? (state as CheckPointListLoaded).activeFilter
        : VisibilityFilter.all;
    yield CheckPointListLoaded(
        _mapCheckpointToFilter(
            (checkpointManBloc.state as CheckpointManLoadSuccess).checkpoints,
            visisbilityFilter),
        visisbilityFilter);
  }

  List<CheckpointModel> _mapCheckpointToFilter(
      List<CheckpointModel> checkpoints, VisibilityFilter filter) {
    return checkpoints.where((checkpoint) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !checkpoint.pointComplete;
      } else {
        return checkpoint.pointComplete;
      }
    }).toList();
  }

  @override
  Future<void> close() {
    checkpointSubscription?.cancel();
    return super.close();
  }
}
