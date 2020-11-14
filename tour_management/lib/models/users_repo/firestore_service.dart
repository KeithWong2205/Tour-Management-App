import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tour_management/models/users_repo/users_repo.dart';

//Firestore service for handling user data
class FireStoreService {
  final CollectionReference _userCollectionReference =
      FirebaseFirestore.instance.collection('users');

  //Create user in the collection
  Future createUser(UserModel userModel) async {
    await _userCollectionReference
        .doc(userModel.id)
        .set(userModel.toEntity().toJson());
  }

  //Get user from collection
  Future<UserModel> getUser(String uid) async {
    try {
      var userData = await _userCollectionReference.doc(uid).get();
      return UserModel.fromData(userData.data());
    } catch (e) {
      return e.message;
    }
  }

  Future getAllUser() async {
    // ignore: deprecated_member_use
    return Firestore.instance.collection('users').getDocuments();
  }

  Stream<List<UserModel>> users({String groupId}) {
    Stream<QuerySnapshot> _query;
    if (groupId != null && groupId.isNotEmpty) {
      _query = _userCollectionReference
          .where('groupID', isEqualTo: groupId)
          .snapshots();
    } else {
      _query = _userCollectionReference.snapshots();
    }
    return _query.map((snapshot) {
      return snapshot.docs
          .map((doc) => UserModel.fromEntity(UserEntity.fromSnapshot(doc)))
          .toList();
    });
  }
}
