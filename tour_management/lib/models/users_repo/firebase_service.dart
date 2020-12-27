import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tour_management/helper/AppDataHelper.dart';
import 'package:tour_management/helper/FCMHelper.dart';
import 'package:tour_management/models/users_repo/users_repo.dart';
import 'package:tour_management/views/views.dart';

//Firebase service for login handling
class FireBaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FireStoreService _fireStoreService = FireStoreService();
  UserModel _currUser;
  UserModel get currUser => _currUser;

  //Sign-in using email and password
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
      @required String phone}) async {
    try {
      var registerResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _fireStoreService.createUser(UserModel(
          id: registerResult.user.uid,
          name: name,
          email: email,
          phone: phone,
          groupID: 'Group 1',
          role: 'guide'));
    } catch (e) {
      return e.message;
    }
  }

  //Sign-out
  Future<void> signOutUser() async {
    return Future.wait([
      _firebaseAuth.signOut().then((value) {
        AppDataHelper.getUser().then((user) {
          if (user.isManager()) {
            FCMHelper.unsubscribe(topic: FCMHelper.MANAGER_CHANNEL);
          } else {
            FCMHelper.unsubscribe(topic: user.groupID);
          }
          FCMHelper.unsubscribe(topic: user.id);
        });
        AppDataHelper.clearUser();
      })
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

  Future getCurrentUser() async {
    // ignore: await_only_futures
    return await _firebaseAuth.currentUser;
  }

  //Fetching the user data
  Future _fetchCurrentUser(User user) async {
    if (user != null) {
      _currUser = await _fireStoreService.getUser(user.uid);
      AppDataHelper.setUser(_currUser);
    }
  }

  //Checking user role for checkpoint list
  checkRoleCheckpointUser(BuildContext context) async {
    var user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: user.uid)
        .get()
        .then((docs) {
      if (docs.docs[0].exists) {
        if (docs.docs[0].data()['role'] == 'manager') {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ManagerCheckPointPage()));
        } else if (docs.docs[0].data()['role'] == 'guide') {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => GuideCheckPointPage()));
        }
      }
    });
  }

  checkRoleGroupUser(BuildContext context) async {
    var user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: user.uid)
        .get()
        .then((docs) {
      if (docs.docs[0].exists) {
        if (docs.docs[0].data()['role'] == 'manager') {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ManagerGroupPage()));
        } else if (docs.docs[0].data()['role'] == 'guide') {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => GuideGroupPage()));
        }
      }
    });
  }

  Future<void> addUserInfo(userData) async {
    FirebaseFirestore.instance
        .collection("users")
        .add(userData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserInfo(String email) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get()
        .catchError((e) {
      print(e.toString());
    });
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
