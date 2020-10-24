import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tour_management/helper/SharedPreferencesHelper.dart';
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
    return Future.wait(
        [
          _firebaseAuth.signOut().then((value) => {
            AppDataHelper.clearUser()
          })
        ]
    );
  }

  //Check sign-in status
  Future<bool> signedInStatus() async {
    final currentUser = await _firebaseAuth.currentUser();
    await _fetchCurrentUser(currentUser);
    return currentUser != null;
  }

  //Get user from database
  Future<String> getUser() async {
    return (await _firebaseAuth.currentUser()).email;
  }

  //Reset password
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  //Fetching the user data
  Future _fetchCurrentUser(FirebaseUser user) async {
    if (user != null) {
      _currUser = await _fireStoreService.getUser(user.uid);
      AppDataHelper.setUser(_currUser);
    }
  }

  //Checking user role for checkpoint list
  checkRoleCheckpointUser(BuildContext context) async {
    FirebaseAuth.instance.currentUser().then((user) {
      Firestore.instance
          .collection('users')
          .where('id', isEqualTo: user.uid)
          .getDocuments()
          .then((docs) {
        if (docs.documents[0].exists) {
          if (docs.documents[0].data['role'] == 'manager') {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ManagerCheckPointPage()));
          } else if (docs.documents[0].data['role'] == 'guide') {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => GuideCheckPointPage())
            );
          }
        }
      });
    });
  }

  checkRoleGroupUser(BuildContext context) async {
    FirebaseAuth.instance.currentUser().then((user) {
      Firestore.instance
          .collection('users')
          .where('id', isEqualTo: user.uid)
          .getDocuments()
          .then((docs) {
        if (docs.documents[0].exists) {
          if (docs.documents[0].data['role'] == 'manager') {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ManagerGroupPage()));
          } else if (docs.documents[0].data['role'] == 'guide') {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => GuideGroupPage()));
          }
        }
      });
    });
  }

  Future<void> addUserInfo(userData) async {
    Firestore.instance.collection("users").add(userData).catchError((e) {
      print(e.toString());
    });
  }

  getUserInfo(String email) async {
    return Firestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .getDocuments()
        .catchError((e) {
      print(e.toString());
    });
  }

  searchByName(String searchField) {
    return Firestore.instance
        .collection("users")
        .where('name', isEqualTo: searchField)
        .getDocuments();
  }

   addChatRoom(chatRoom, chatRoomId) async {
    return await Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .setData(chatRoom);
  }

  getChats(String chatRoomId) async{
    return Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }


  Future<void> addMessage(String chatRoomId, chatMessageData){
    Firestore.instance.collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(chatMessageData).catchError((e){
      print(e.toString());
    });
  }

  Future getUserChats() async {
    final QuerySnapshot querySnapshot = await Firestore.instance.collection("users").getDocuments();
    final currentUser = await _firebaseAuth.currentUser();
    await _fetchCurrentUser(currentUser);
    if (_currUser != null && querySnapshot.documents.isNotEmpty){
      querySnapshot.documents.removeWhere((user) => user.data['id'] == currentUser.uid);
    }
    return querySnapshot;
  }

  Future<FirebaseUser> getCurrentUser() async {
    return await FirebaseAuth.instance.currentUser();
  }
}
