import 'package:equatable/equatable.dart';
import 'package:chpnt_repo_manager/chpnt_repo_manager.dart';

//Class for events on checkpoint operations
class CheckpointManEvent extends Equatable {
  const CheckpointManEvent();
  @override
  List<Object> get props => [];
}

//Event on load success
class CheckpointManLoaded extends CheckpointManEvent {
  @override
  String toString() => 'Checkpoints loaded';
}

//Event on add checkpoint
class CheckpointManAdded extends CheckpointManEvent {
  final CheckpointModel checkpoint;
  const CheckpointManAdded(this.checkpoint);
  @override
  List<Object> get props => [checkpoint];
}

//Event on update or edit checkpoint
class CheckpointManUpdated extends CheckpointManEvent {
  final CheckpointModel updated;
  const CheckpointManUpdated(this.updated);
  @override
  List<Object> get props => [updated];
}

//Event on delete checkpoint
class CheckpointManDelete extends CheckpointManEvent {
  final CheckpointModel deleted;
  const CheckpointManDelete(this.deleted);
  @override
  List<Object> get props => [deleted];
}

//Event on update list of checkpoints
class CheckpointListManUpdate extends CheckpointManEvent {
  final List<CheckpointModel> updatedList;
  const CheckpointListManUpdate(this.updatedList);
  @override
  List<Object> get props => [updatedList];
}
