import 'dart:async';
import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../group_repo.dart';
import 'group_entity.dart';
import 'group_entity.dart';
import 'group_model.dart';
import 'group_model.dart';
import 'group_model.dart';

//Class for handling group to firestore
class FirebaseGroupService {
  final groupCollection = Firestore.instance.collection('groups');

  //Adding a new group item to collection
  Future<void> addNewGroup(GroupModel addedGroup) {
    return groupCollection.add(addedGroup.toEntity().toDocument());
  }

  //Deleting a group item from collection
  Future<void> deleteGroup(GroupModel deletedGroup) {
    return groupCollection.document(deletedGroup.groupId).delete();
  }

  //Load the groups onto the view
  Stream<List<GroupModel>> groups() {
    return groupCollection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => GroupModel.fromEntity(GroupEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  //Update a group detail
  Future<void> updateGroup(GroupModel updatedGroup) {
    return groupCollection
        .document(updatedGroup.groupId)
        .updateData(updatedGroup.toEntity().toDocument());
  }
}
