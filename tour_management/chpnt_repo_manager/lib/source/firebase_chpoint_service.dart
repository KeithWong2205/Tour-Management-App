import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../chpnt_repo_manager.dart';

//Class for handling checkpoint to firestore
class FirebaseCheckpointService {
  final checkpointCollection = FirebaseFirestore.instance.collection('checkpoints');

  //Add a checkpoint to firestore document
  Future<void> addNewCheckpoint(CheckpointModel addedCheckpoint) {
    return checkpointCollection.add(addedCheckpoint.toEntity().toDocument());
  }

  //Delete a checkpoint
  Future<void> deleteCheckpoint(CheckpointModel deletedCheckpoint) async {
    return checkpointCollection.doc(deletedCheckpoint.pointId).delete();
  }

  //Load the checkpoints into a stream
  Stream<List<CheckpointModel>> checkpoints({String groupId}) {
    Stream<QuerySnapshot> _query;
    if (groupId != null && groupId.isNotEmpty) {
      _query = checkpointCollection.where('pointGroup', isEqualTo: groupId).snapshots();
    } else {
      _query = checkpointCollection.snapshots();
    }
    return _query.map((snapshot) {
      return snapshot.docs
          .map((doc) =>
          CheckpointModel.fromEntity(CheckpointEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  //Update a checkpoint details
  Future<void> updateCheckpoint(CheckpointModel updated) {
    return checkpointCollection
        .doc(updated.pointId)
        .update(updated.toEntity().toDocument());
  }
}
