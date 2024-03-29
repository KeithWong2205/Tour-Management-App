import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tour_participant/models/student_repo/student_repo.dart';
import 'package:tour_participant/helper/SharedPreferencesHelper.dart';

class FirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FireStoreService _fireStoreService = FireStoreService();
  UserModel _currStudent;
  UserModel get currStudent => _currStudent;

  //Sign-in with email and password
  Future<void> signInWithEmailPassword(String email, String password) async {
    try {
      var loginResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      await _fetchCurrentUser(loginResult.user);
      return loginResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  //Sign-up a user
  Future<void> signUpNewUser(
      {@required String email,
      @required String password,
      @required String name,
      @required String phone,
      @required String groupId}) async {
    try {
      var registerResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _fireStoreService.createStudent(UserModel(
          id: registerResult.user.uid,
          name: name,
          email: email,
          phone: phone,
          groupID: groupId,
          role: 'student'));
    } catch (e) {
      return e.message;
    }
  }

  //Sign-out
  Future<void> signOutUser() async {
    return Future.wait([
      _firebaseAuth.signOut().then((value) => {AppDataHelper.clearUser()})
    ]);
  }

  //Check sign-in status
  Future<bool> signedInStatus() async {
    final currentUser = _firebaseAuth.currentUser;
    await _fetchCurrentUser(currentUser);
    return currentUser != null;
  }

  //Get user from database
  Future<String> getUser() async {
    return (_firebaseAuth.currentUser).email;
  }

  //Reset password
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  //Fetching the user data
  Future _fetchCurrentUser(User user) async {
    if (user != null) {
      _currStudent = await _fireStoreService.getStudent(user.uid);
      AppDataHelper.setUser(_currStudent);
    }
  }

  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection("users")
        .where('name', isGreaterThanOrEqualTo: searchField.toUpperCase())
        .where('name', isLessThanOrEqualTo: searchField + '~')
        .get();
  }

  addChatRoom(chatRoom, chatRoomId) async {
    return await FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .set(chatRoom);
  }

  getChats(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  // ignore: missing_return
  Future<void> addMessage(String chatRoomId, chatMessageData) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future getUserChats() async {
    return FirebaseFirestore.instance.collection("users").get();
  }
}
