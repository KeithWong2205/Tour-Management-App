import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

//Class for checkpoint entity
class CheckpointEntity extends Equatable {
  final bool pointComplete;
  final String pointId;
  final String pointName;
  final String pointLocal;
  final DateTime pointDatetime;
  final String pointNote;
  final String pointGroup;
  final String pointPhotoUrl;
  final double totalRating;
  final double totalRatingStar;
  const CheckpointEntity(
      this.pointComplete,
      this.pointId,
      this.pointGroup,
      this.pointName,
      this.pointLocal,
      this.pointDatetime,
      this.pointNote,
      this.pointPhotoUrl,
      this.totalRating,
      this.totalRatingStar);
  @override
  List<Object> get props => [
    pointComplete,
    pointId,
    pointGroup,
    pointName,
    pointLocal,
    pointDatetime,
    pointNote,
    pointPhotoUrl,
    totalRating,
    totalRatingStar
  ];
  @override
  String toString() =>
      'Checkpoint Entity created {status: $pointComplete, id: $pointId, group: $pointGroup, name: $pointName, location: $pointLocal, datetime: $pointDatetime, note: $pointNote, photoUrl: $pointPhotoUrl, totalRating: $totalRating, totalRatingStar: $totalRatingStar}';

  //Map the entity into Json to send to firestore
  Map<String, Object> toJson() {
    return {
      'pointComplete': pointComplete,
      'pointId': pointId,
      'pointGroup': pointGroup,
      'pointName': pointName,
      'pointLocal': pointLocal,
      'pointDatetime': pointDatetime.toString(),
      'pointPhotoUrl': pointPhotoUrl,
      'totalRating': totalRating,
      'totalRatingStar': totalRatingStar
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
        json['pointDatetime'] as DateTime,
        json['pointNote'] as String,
        json['pointPhotoUrl'] as String,
        json['totalRating'] as double,
        json['totalRatingStar'] as double);
  }

  //Get the checkpoint entity from firestore document snapshot
  static CheckpointEntity fromSnapshot(DocumentSnapshot snapshot) {
    DateTime pointDate = snapshot.data()['pointDatetime'].toDate();
    return CheckpointEntity(
        snapshot.data()['pointComplete'],
        snapshot.id,
        snapshot.data()['pointGroup'],
        snapshot.data()['pointName'],
        snapshot.data()['pointLocal'],
        pointDate,
        snapshot.data()['pointNote'],
        snapshot.data()['pointPhotoUrl'],
        snapshot.data()['totalRating'],
        snapshot.data()['totalRatingStar']);
  }

  //Map checkpoint entity to firestore document
  Map<String, Object> toDocument() {
    return {
      'pointComplete': pointComplete,
      'pointGroup': pointGroup,
      'pointName': pointName,
      'pointLocal': pointLocal,
      'pointDatetime': pointDatetime,
      'pointNote': pointNote,
      'pointPhotoUrl': pointPhotoUrl,
      'totalRating': totalRating,
      'totalRatingStar': totalRatingStar
    };
  }
}
