import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tour_participant/models/student_repo/student_repo.dart';

//Firestore service for student collection, this will share the same collection of users
class FireStoreService {
  final CollectionReference _studentCollectionRef =
      Firestore.instance.collection('users');

  //Create a new student in the firestore collection
  Future createStudent(Student student) async {
    await _studentCollectionRef.document(student.id).setData(student.toJson());
  }

  //Get user from collection
  Future getStudent(String uid) async {
    try {
      var userData = await _studentCollectionRef.document(uid).get();
      return Student.fromData(userData.data);
    } catch (e) {
      return e.message;
    }
  }
}