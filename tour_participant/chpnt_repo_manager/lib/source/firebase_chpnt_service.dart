import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../chpnt_repo_manager.dart';

//Class for handling checkpoint to firestore
class FirebaseCheckpointService {
  // ignore: deprecated_member_use
  final checkpointCollection = Firestore.instance.collection('checkpoints');

  //Add a checkpoint to firestore document
  Future<void> addNewCheckpoint(CheckpointModel addedCheckpoint) {
    return checkpointCollection.add(addedCheckpoint.toEntity().toDocument());
  }

  //Delete a checkpoint
  Future<void> deleteCheckpoint(CheckpointModel deletedCheckpoint) async {
    // ignore: deprecated_member_use
    return checkpointCollection.document(deletedCheckpoint.pointId).delete();
  }

  //Load the checkpoints into a stream
  Stream<List<CheckpointModel>> checkpoints({String groupId}) {
    Stream<QuerySnapshot> _query;
    if (groupId != null && groupId.isNotEmpty) {
      _query = checkpointCollection
          .where('pointGroup', isEqualTo: groupId)
          .snapshots();
    } else {
      _query = checkpointCollection.snapshots();
    }
    return _query.map((snapshot) {
      // ignore: deprecated_member_use
      return snapshot.documents
          .map((doc) =>
              CheckpointModel.fromEntity(CheckpointEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  //Update a checkpoint details
  Future<void> updateCheckpoint(CheckpointModel updated) {
    return checkpointCollection
        // ignore: deprecated_member_use
        .document(updated.pointId)
        // ignore: deprecated_member_use
        .updateData(updated.toEntity().toDocument());
  }
}
