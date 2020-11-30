//Class for handling feedback to firestore
import 'package:cloud_firestore/cloud_firestore.dart';

import '../feedback_repo.dart';

class FirebaseFeedbackService {
  final checkpointCollection = Firestore.instance.collection('feedbacks');

  //Add a feedback to firestore document
  Future<void> addNewFeedback(FeedbackModel addedFeedback) {
    return checkpointCollection.add(addedFeedback.toEntity().toDocument());
  }
}