import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:user_repository/user_repository.dart';

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
          groupID: '0',
          role: 'guide'));
    } catch (e) {
      return e.message;
    }
  }

  //Sign-out
  Future<void> signOutUser() async {
    return Future.wait([_firebaseAuth.signOut()]);
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

  Future _fetchCurrentUser(FirebaseUser user) async {
    if (user != null) {
      _currUser = await _fireStoreService.getUser(user.uid);
    }
  }
}
