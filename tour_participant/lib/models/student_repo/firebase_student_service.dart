import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tour_participant/models/student_repo/student_repo.dart';
import 'package:tour_participant/helper/SharedPreferencesHelper.dart';

class FirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FireStoreService _fireStoreService = FireStoreService();
  Student _currStudent;
  Student get currStudent => _currStudent;

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
      @required String phone}) async {
    try {
      var registerResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _fireStoreService.createStudent(Student(
          id: registerResult.user.uid,
          name: name,
          email: email,
          phone: phone,
          groupId: 'Group 1',
          role: 'guide'));
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
      _currStudent = await _fireStoreService.getStudent(user.uid);
      AppDataHelper.setUser(_currStudent);
    }
  }
}
