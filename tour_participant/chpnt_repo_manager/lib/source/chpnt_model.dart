import 'package:meta/meta.dart';
import '../chpnt_repo_manager.dart';

//Class for the model of the checkpoints
enum VisibilityFilter { all, active, completed }

@immutable
class CheckpointModel {
  final bool pointComplete;
  final bool pointCheckin;
  final String pointId;
  final String pointGroup;
  final String pointName;
  final String pointLocal;
  final DateTime pointDatetime;
  final String pointNote;
  final String pointPhotoUrl;
  final double totalRating;
  final double totalRatingStar;
  CheckpointModel(this.pointName,
      {this.pointComplete = false,
      this.pointCheckin = false,
      String pointId,
      String pointGroup = '0',
      String pointLocal = '',
      DateTime pointDatetime,
      String pointNote = '',
      String pointPhotoUrl = '',
      double totalRating,
      double totalRatingStar})
      : this.pointId = pointId,
        this.pointGroup = pointGroup ?? '0',
        this.pointLocal = pointLocal ?? '',
        this.pointDatetime = pointDatetime ?? DateTime.now(),
        this.pointNote = pointNote ?? '',
        this.pointPhotoUrl = pointPhotoUrl ?? '',
        this.totalRating = totalRating ?? 1,
        this.totalRatingStar = totalRatingStar ?? 2.5;

  //Passing the parameters
  CheckpointModel copyWith(
      {bool complete,
      bool checkin,
      String id,
      String name,
      String group,
      String location,
      DateTime dateTime,
      String note,
      String photoUrl,
      double totalRating,
      double totalRatingStar}) {
    return CheckpointModel(name ?? this.pointName,
        pointComplete: complete ?? this.pointComplete,
        pointCheckin: checkin ?? this.pointCheckin,
        pointId: id ?? this.pointId,
        pointGroup: group ?? this.pointGroup,
        pointLocal: location ?? this.pointLocal,
        pointDatetime: dateTime ?? this.pointDatetime,
        pointNote: note ?? this.pointNote,
        pointPhotoUrl: photoUrl ?? this.pointPhotoUrl,
        totalRating: totalRating ?? this.totalRating,
        totalRatingStar: totalRatingStar ?? this.totalRatingStar);
  }

  //Get hashcode
  @override
  int get hashCode =>
      pointComplete.hashCode ^
      pointCheckin.hashCode ^
      pointId.hashCode ^
      pointGroup.hashCode ^
      pointName.hashCode ^
      pointLocal.hashCode ^
      pointDatetime.hashCode ^
      pointNote.hashCode ^
      pointPhotoUrl.hashCode ^
      totalRating.hashCode ^
      totalRatingStar.hashCode;
//== operator override
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckpointModel &&
          runtimeType == other.runtimeType &&
          pointComplete == other.pointComplete &&
          pointCheckin == other.pointCheckin &&
          pointId == other.pointId &&
          pointGroup == other.pointGroup &&
          pointName == other.pointName &&
          pointLocal == other.pointLocal &&
          pointDatetime == other.pointDatetime &&
          pointNote == other.pointNote &&
          pointPhotoUrl == other.pointPhotoUrl &&
          totalRating == other.totalRating &&
          totalRatingStar == other.totalRatingStar;

  @override
  String toString() =>
      'Checkpoint Model {status: $pointComplete, id: $pointId, group: $pointGroup, name: $pointName, location: $pointLocal, datetime: $pointDatetime, note: $pointNote, photoUrl: $pointPhotoUrl, totalRating: $totalRating, totalRatingStar: $totalRatingStar}';

  //Make model into checkpoint entity to send to firestore
  CheckpointEntity toEntity() {
    return CheckpointEntity(
        pointComplete,
        pointCheckin,
        pointId,
        pointGroup,
        pointName,
        pointLocal,
        pointDatetime,
        pointNote,
        pointPhotoUrl,
        totalRating,
        totalRatingStar);
  }

  //Get the checkpoint model from the entity acquire from firestore
  static CheckpointModel fromEntity(CheckpointEntity entity) {
    return CheckpointModel(entity.pointName,
        pointComplete: entity.pointComplete ?? false,
        pointCheckin: entity.pointCheckin ?? false,
        pointId: entity.pointId,
        pointGroup: entity.pointGroup,
        pointLocal: entity.pointLocal,
        pointDatetime: entity.pointDatetime,
        pointNote: entity.pointNote,
        pointPhotoUrl: entity.pointPhotoUrl,
        totalRating: entity.totalRating,
        totalRatingStar: entity.totalRatingStar);
  }
}
