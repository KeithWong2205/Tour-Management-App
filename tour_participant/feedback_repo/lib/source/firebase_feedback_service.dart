//Class for handling feedback to firestore
import 'package:cloud_firestore/cloud_firestore.dart';

import '../feedback_repo.dart';

class FirebaseFeedbackService {
  // ignore: deprecated_member_use
  final feedbackCollection = Firestore.instance.collection('feedbacks');

  //Add a checkpoint to firestore document
  Future<void> addNewFeedback(FeedbackModel addedFeedback) {
    return feedbackCollection.add(addedFeedback.toEntity().toDocument());
  }

  //Delete a checkpoint
  Future<void> deleteCheckpoint(FeedbackModel deletedFeedback) async {
    // ignore: deprecated_member_use
    return feedbackCollection.document(deletedFeedback.feedbackID).delete();
  }

  //Load the checkpoints into a stream
  Stream<List<FeedbackModel>> feedbackList({String queryId}) {
    Stream<QuerySnapshot> _query;
    if (queryId != null && queryId.isNotEmpty) {
      _query = feedbackCollection.where('X', isEqualTo: queryId).snapshots();
    } else {
      _query = feedbackCollection.snapshots();
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
  Future<void> updateFeedback(FeedbackModel updated) {
    return feedbackCollection
        // ignore: deprecated_member_use
        .document(updated.feedbackID)
        // ignore: deprecated_member_use
        .updateData(updated.toEntity().toDocument());
  }
}
