import 'package:meta/meta.dart';
import '../chpnt_repo_manager.dart';

//Class for the model of the checkpoints
enum VisibilityFilter { all, active, completed }

@immutable
class CheckpointModel {
  final bool pointComplete;
  final String pointId;
  final String pointGroup;
  final String pointName;
  final String pointLocal;
  final DateTime pointDatetime;
  final String pointNote;
  final double totalRating;
  final double totalRatingStar;
  CheckpointModel(this.pointName,
      {this.pointComplete = false,
      String pointId,
      String pointGroup = '0',
      String pointLocal = '',
      DateTime pointDatetime,
      String pointNote = '',
      double totalRating,
      double totalRatingStar})
      : this.pointId = pointId,
        this.pointGroup = pointGroup ?? '0',
        this.pointLocal = pointLocal ?? '',
        this.pointDatetime = pointDatetime ?? DateTime.now(),
        this.pointNote = pointNote ?? '',
        this.totalRating = totalRating ?? 1,
        this.totalRatingStar = totalRatingStar ?? 2.5;

  //Passing the parameters
  CheckpointModel copyWith(
      {bool complete,
      String id,
      String name,
      String group,
      String location,
      DateTime dateTime,
      String note,
      double totalRating,
      double totalRatingStar}) {
    return CheckpointModel(name ?? this.pointName,
        pointComplete: complete ?? this.pointComplete,
        pointId: id ?? this.pointId,
        pointGroup: group ?? this.pointGroup,
        pointLocal: location ?? this.pointLocal,
        pointDatetime: dateTime ?? this.pointDatetime,
        pointNote: note ?? this.pointNote,
        totalRating: totalRating ?? this.totalRating,
        totalRatingStar: totalRatingStar ?? this.totalRatingStar);
  }

  //Get hashcode
  @override
  int get hashCode =>
      pointComplete.hashCode ^
      pointId.hashCode ^
      pointGroup.hashCode ^
      pointName.hashCode ^
      pointLocal.hashCode ^
      pointDatetime.hashCode ^
      pointNote.hashCode ^
      totalRating.hashCode ^
      totalRatingStar.hashCode;
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
          pointDatetime == other.pointDatetime &&
          pointNote == other.pointNote &&
          totalRating == other.totalRating &&
          totalRatingStar == other.totalRatingStar;

  @override
  String toString() =>
      'Checkpoint Model {status: $pointComplete, id: $pointId, group: $pointGroup, name: $pointName, location: $pointLocal, datetime: $pointDatetime, note: $pointNote, totalRating: $totalRating, totalRatingStar: $totalRatingStar}';

  //Make model into checkpoint entity to send to firestore
  CheckpointEntity toEntity() {
    return CheckpointEntity(pointComplete, pointId, pointGroup, pointName,
        pointLocal, pointDatetime, pointNote, totalRating, totalRatingStar);
  }

  //Get the checkpoint model from the entity acquire from firestore
  static CheckpointModel fromEntity(CheckpointEntity entity) {
    return CheckpointModel(entity.pointName,
        pointComplete: entity.pointComplete ?? false,
        pointId: entity.pointId,
        pointGroup: entity.pointGroup,
        pointLocal: entity.pointLocal,
        pointDatetime: entity.pointDatetime,
        pointNote: entity.pointNote,
        totalRating: entity.totalRating,
        totalRatingStar: entity.totalRatingStar);
  }
}