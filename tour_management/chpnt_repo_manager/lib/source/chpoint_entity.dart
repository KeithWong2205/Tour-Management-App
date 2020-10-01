import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

//Class for checkpoint entity
class CheckpointEntity extends Equatable {
  final bool pointComplete;
  final String pointId;
  final String pointName;
  final String pointLocal;
  final String pointNote;
  final String pointGroup;
  const CheckpointEntity(this.pointComplete, this.pointId, this.pointGroup,
      this.pointName, this.pointLocal, this.pointNote);
  @override
  List<Object> get props =>
      [pointComplete, pointId, pointGroup, pointName, pointLocal, pointNote];
  @override
  String toString() =>
      'Checkpoint Entity created {status: $pointComplete, id: $pointId, group: $pointGroup, name: $pointName, location: $pointLocal, note: $pointNote}';

  //Map the entity into Json to send to firestore
  Map<String, Object> toJson() {
    return {
      'pointComplete': pointComplete,
      'pointId': pointId,
      'pointGroup': pointGroup,
      'pointName': pointName,
      'pointLocal': pointLocal,
      'pointNote': pointNote
    };
  }

  //Get the checkpoint entity from Json from firestore
  static CheckpointEntity fromJson(Map<String, Object> json) {
    return CheckpointEntity(
        json['pointComplete'] as bool,
        json['pointId'] as String,
        json['pointGroup'] as String,
        json['pointName'] as String,
        json['pointLocal'] as String,
        json['pointNote'] as String);
  }

  //Get the checkpoint entity from firestore document snapshot
  static CheckpointEntity fromSnapshot(DocumentSnapshot snapshot) {
    return CheckpointEntity(
        snapshot.data['pointComplete'],
        snapshot.documentID,
        snapshot.data['pointGroup'],
        snapshot.data['pointName'],
        snapshot.data['pointLocal'],
        snapshot.data['pointNote']);
  }

  //Map checkpoint entity to firestore document
  Map<String, Object> toDocument() {
    return {
      'pointComplete': pointComplete,
      'pointGroup': pointGroup,
      'pointName': pointName,
      'pointLocal': pointLocal,
      'pointNote': pointNote
    };
  }
}
