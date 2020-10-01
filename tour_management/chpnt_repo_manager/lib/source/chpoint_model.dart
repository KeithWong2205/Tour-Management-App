import 'package:meta/meta.dart';
import 'package:chpnt_repo_manager/chpnt_repo_manager.dart';

//Class for the model of the checkpoints
@immutable
class CheckpointModel {
  final bool pointComplete;
  final String pointId;
  final String pointGroup;
  final String pointName;
  final String pointLocal;
  final String pointNote;
  CheckpointModel(this.pointName,
      {this.pointComplete = false,
      String pointId,
      String pointGroup = '0',
      String pointLocal = '',
      String pointNote = ''})
      : this.pointId = pointId,
        this.pointGroup = pointGroup ?? '0',
        this.pointLocal = pointLocal ?? '',
        this.pointNote = pointNote ?? '';

  //Passing the parameters
  CheckpointModel copyWith(
      {bool complete,
      String id,
      String name,
      String group,
      String location,
      String note}) {
    return CheckpointModel(name ?? this.pointName,
        pointComplete: complete ?? this.pointComplete,
        pointId: id ?? this.pointId,
        pointGroup: group ?? this.pointGroup,
        pointLocal: location ?? this.pointLocal,
        pointNote: note ?? this.pointNote);
  }

  //Get hashcode
  @override
  int get hashCode =>
      pointComplete.hashCode ^
      pointId.hashCode ^
      pointGroup.hashCode ^
      pointName.hashCode ^
      pointLocal.hashCode ^
      pointNote.hashCode;
//== operator override
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckpointModel &&
          runtimeType == other.runtimeType &&
          pointComplete == other.pointComplete &&
          pointId == other.pointId &&
          pointGroup == other.pointGroup &&
          pointName == other.pointName &&
          pointLocal == other.pointLocal &&
          pointNote == other.pointNote;

  @override
  String toString() =>
      'Checkpoint Model {status: $pointComplete, id: $pointId, group: $pointGroup, name: $pointName, location: $pointLocal, note: $pointNote}';

  //Make model into checkpoint entity to send to firestore
  CheckpointEntity toEntity() {
    return CheckpointEntity(
        pointComplete, pointId, pointGroup, pointName, pointLocal, pointNote);
  }

  //Get the checkpoint model from the entity acquire from firestore
  static CheckpointModel fromEntity(CheckpointEntity entity) {
    return CheckpointModel(entity.pointName,
        pointComplete: entity.pointComplete ?? false,
        pointId: entity.pointId,
        pointGroup: entity.pointGroup,
        pointLocal: entity.pointLocal,
        pointNote: entity.pointNote);
  }
}
