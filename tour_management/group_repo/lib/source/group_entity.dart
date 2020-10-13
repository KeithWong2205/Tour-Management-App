import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

//Class for group entity
class GroupEntity extends Equatable {
  final String groupId;
  final String groupNumber;
  final String groupSchool;
  final String groupGuideName;
  const GroupEntity(
      this.groupId, this.groupNumber, this.groupSchool, this.groupGuideName);
  @override
  List<Object> get props => [groupId, groupNumber, groupSchool, groupGuideName];
  @override
  String toString() =>
      'Group Entity created: {id: $groupId, Number: $groupNumber, school: $groupSchool, groupGuide: $groupGuideName}';

  //Map the group entity to Json to send to firestore
  Map<String, Object> toJson() {
    return {
      'groupId': groupId,
      'groupNumber': groupNumber,
      'groupSchool': groupSchool,
      'groupGuide': groupGuideName
    };
  }

  //Getting the entiry from the json
  static GroupEntity fromJson(Map<String, Object> json) {
    return GroupEntity(json['groupId'] as String, json['groupNumber'] as String,
        json['groupSchool'] as String, json['groupGuide'] as String);
  }

  //Get the group entity from the document snapshot
  static GroupEntity fromSnapshot(DocumentSnapshot snapshot) {
    return GroupEntity(snapshot.data['groupId'], snapshot.data['groupNumber'],
        snapshot.data['groupSchool'], snapshot.data['groupGuide']);
  }

  //Map group entity into document on firestore
  Map<String, Object> toDocument() {
    return {
      'groupId': groupId,
      'groupNumber': groupNumber,
      'groupSchool': groupSchool,
      'groupGuide': groupGuideName
    };
  }
}
