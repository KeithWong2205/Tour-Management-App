import 'package:equatable/equatable.dart';
import 'package:chpnt_repo_manager/chpnt_repo_manager.dart';

//State of checkpoint list
abstract class CheckPointListState extends Equatable {
  const CheckPointListState();
  @override
  List<Object> get props => [];
}

//Loading
class CheckPointListLoadin extends CheckPointListState {
  @override
  String toString() => 'CheckPointList Loading';
}

//Loaded
class CheckPointListLoaded extends CheckPointListState {
  final List<CheckpointModel> checkpoints;
  final VisibilityFilter activeFilter;
  const CheckPointListLoaded(this.checkpoints, this.activeFilter);
  @override
  List<Object> get props => [checkpoints, activeFilter];
  @override
  String toString() =>
      'CheckpointList Loaded {checkpoints: $checkpoints, filter: $activeFilter}';
}
