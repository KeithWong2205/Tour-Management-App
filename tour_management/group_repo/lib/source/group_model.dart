import 'package:meta/meta.dart';
import '../group_repo.dart';

//Class for Group model
@immutable
class GroupModel {
  final String groupId;
  final String groupNumber;
  final String groupSchool;
  GroupModel(
    this.groupNumber, {
    String groupId,
    String groupSchool = '',
    String groupGuideName = '',
  })  : this.groupId = groupId,
        this.groupSchool = groupSchool ?? '';

  //Passing the parameters
  GroupModel copyWith({String id, String number, String school}) {
    return GroupModel(groupNumber ?? this.groupNumber,
        groupId: id ?? this.groupId, groupSchool: school ?? this.groupSchool);
  }

  //Check hashcode
  @override
  int get hashCode =>
      groupId.hashCode ^ groupNumber.hashCode ^ groupSchool.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupModel &&
          runtimeType == other.runtimeType &&
          groupId == other.groupId &&
          groupNumber == other.groupNumber &&
          groupSchool == other.groupSchool;
  @override
  String toString() =>
      'Group Model created {id: $groupId, number: $groupNumber, school: $groupSchool}';

  //Map model to entity
  GroupEntity toEntity() {
    return GroupEntity(groupId, groupNumber, groupSchool);
  }

  //Get group model from group entity
  static GroupModel fromEntity(GroupEntity entity) {
    return GroupModel(entity.groupNumber,
        groupId: entity.groupId, groupSchool: entity.groupSchool);
  }
}
