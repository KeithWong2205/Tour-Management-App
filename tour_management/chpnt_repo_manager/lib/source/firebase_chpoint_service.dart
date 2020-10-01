import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chpnt_repo_manager/chpnt_repo_manager.dart';

class FirebaseCheckpointService {
  final checkpointCollection = Firestore.instance.collection('checkpoints');

  //Add a checkpoint to firestore document
  Future<void> addNewCheckpoint(CheckpointModel checkpoint) {
    return checkpointCollection.add(checkpoint.toEntity().toDocument());
  }

  //Delete a checkpoint
  Future<void> deleteCheckpoint(CheckpointModel checkpoint) async {
    return checkpointCollection.document(checkpoint.pointId).delete();
  }

  //Load the checkpoints into a stream
  Stream<List<CheckpointModel>> checkpoints() {
    return checkpointCollection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) =>
              CheckpointModel.fromEntity(CheckpointEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  //Update a checkpoint details
  Future<void> updateCheckpoint(CheckpointModel updated) {
    return checkpointCollection
        .document(updated.pointId)
        .updateData(updated.toEntity().toDocument());
  }
}
