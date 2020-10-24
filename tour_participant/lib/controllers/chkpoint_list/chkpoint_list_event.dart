import 'package:equatable/equatable.dart';
import 'package:chpnt_repo_manager/chpnt_repo_manager.dart';

//Event of checkpoint list
abstract class CheckPointListEvent extends Equatable {
  const CheckPointListEvent();
  @override
  List<Object> get props => [];
}

//Update on checkpoint list
class CheckPointListUpdated extends CheckPointListEvent {
  final List<CheckpointModel> checkpoints;
  const CheckPointListUpdated(this.checkpoints);
  @override
  List<Object> get props => [checkpoints];
  @override
  String toString() => 'Checkpoint List Updated {checkpoints: $checkpoints}';
}
