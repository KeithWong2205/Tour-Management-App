import 'package:meta/meta.dart';
import '../group_repo.dart';

//Class for Group model
@immutable
class GroupModel {
  final String groupId;
  final String groupNumber;
  final String groupSchool;
  final String groupGuideName;
  GroupModel(
    this.groupNumber, {
    String groupId,
    String groupSchool = '',
    String groupGuideName = '',
  })  : this.groupId = groupId,
        this.groupSchool = groupSchool ?? '',
        this.groupGuideName = groupGuideName ?? '';

  //Passing the parameters
  GroupModel copyWith({String id, String number, String school, String guide}) {
    return GroupModel(groupNumber ?? this.groupNumber,
        groupId: id ?? this.groupId,
        groupSchool: school ?? this.groupSchool,
        groupGuideName: guide ?? this.groupGuideName);
  }

  //Check hashcode
  @override
  int get hashCode =>
      groupId.hashCode ^
      groupNumber.hashCode ^
      groupSchool.hashCode ^
      groupGuideName.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupModel &&
          runtimeType == other.runtimeType &&
          groupId == other.groupId &&
          groupNumber == other.groupNumber &&
          groupSchool == other.groupSchool &&
          groupGuideName == other.groupGuideName;
  @override
  String toString() =>
      'Group Model created {id: $groupId, number: $groupNumber, school: $groupSchool, guide: $groupGuideName}';

  //Map model to entity
  GroupEntity toEntity() {
    return GroupEntity(groupId, groupNumber, groupSchool, groupGuideName);
  }

  //Get group model from group entity
  static GroupModel fromEntity(GroupEntity entity) {
    return GroupModel(entity.groupNumber,
        groupId: entity.groupId,
        groupSchool: entity.groupSchool,
        groupGuideName: entity.groupGuideName);
  }
}
