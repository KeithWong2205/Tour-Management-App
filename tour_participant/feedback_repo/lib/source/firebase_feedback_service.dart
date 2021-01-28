//Class for handling feedback to firestore
import 'package:cloud_firestore/cloud_firestore.dart';

import '../feedback_repo.dart';

class FirebaseFeedbackService {
  // ignore: deprecated_member_use
  final checkpointCollection = Firestore.instance.collection('feedbacks');

  //Add a checkpoint to firestore document
  Future<void> addNewFeedback(FeedbackModel addedFeedback) {
    return checkpointCollection.add(addedFeedback.toEntity().toDocument());
  }

  //Delete a checkpoint
  Future<void> deleteCheckpoint(FeedbackModel deletedFeedback) async {
    // ignore: deprecated_member_use
    return checkpointCollection.document(deletedFeedback.feedbackID).delete();
  }

  //Load the checkpoints into a stream
  Stream<List<FeedbackModel>> feedbackList({String queryId}) {
    Stream<QuerySnapshot> _query;
    if (queryId != null && queryId.isNotEmpty) {
      _query = checkpointCollection.where('X', isEqualTo: queryId).snapshots();
    } else {
      _query = checkpointCollection.snapshots();
    }
    return _query.map((snapshot) {
      // ignore: deprecated_member_use
      return snapshot.documents
          .map((doc) =>
              FeedbackModel.fromEntity(FeedbackEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  //Update a checkpoint details
  Future<void> updateCheckpoint(FeedbackModel updated) {
    return checkpointCollection
        // ignore: deprecated_member_use
        .document(updated.feedbackID)
        // ignore: deprecated_member_use
        .updateData(updated.toEntity().toDocument());
  }
}
