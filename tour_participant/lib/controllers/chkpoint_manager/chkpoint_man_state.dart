import 'package:equatable/equatable.dart';
import 'package:chpnt_repo_manager/chpnt_repo_manager.dart';

//Class for states of checkpoint operations
class CheckpointManState extends Equatable {
  const CheckpointManState();
  @override
  List<Object> get props => [];
}

//Loading state
class CheckpointManLoadin extends CheckpointManState {
  @override
  String toString() => 'Checkpoints are loading';
}

//Load Success
class CheckpointManLoadSuccess extends CheckpointManState {
  final List<CheckpointModel> checkpoints;
  const CheckpointManLoadSuccess([this.checkpoints = const []]);
  @override
  List<Object> get props => [checkpoints];
  @override
  String toString() => 'Checkpoints loaded {checkpoints: $checkpoints}';
}

//Load Failed
class CheckpointManLoadFail extends CheckpointManState {
  @override
  String toString() => 'Checkpoints failed to load';
}
