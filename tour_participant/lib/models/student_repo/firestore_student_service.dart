import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tour_participant/models/student_repo/student_repo.dart';
import 'package:tour_participant/models/student_repo/user_entity.dart';
import 'package:tour_participant/models/student_repo/user_model.dart';

//Firestore service for student collection, this will share the same collection of users
class FireStoreService {
  final CollectionReference _studentCollectionRef = FirebaseFirestore.instance.collection('users');

  //Create a new student in the firestore collection
  Future createStudent(UserModel student) async {
    await _studentCollectionRef.doc(student.id).set(student.toJson());
  }

  //Get user from collection
  Future getStudent(String uid) async {
    try {
      var userData = await _studentCollectionRef.doc(uid).get();
      return UserModel.fromData(userData.data());
    } catch (e) {
      return e.message;
    }
  }

  Stream<List<UserModel>> users({String groupId}) {
    Stream<QuerySnapshot> _query;
    if (groupId != null && groupId.isNotEmpty) {
      _query = _studentCollectionRef
          .where('groupID', isEqualTo: groupId)
          .snapshots();
    } else {
      _query = _studentCollectionRef.snapshots();
    }
    return _query.map((snapshot) {
      return snapshot.docs
          .map((doc) => UserModel.fromEntity(UserEntity.fromSnapshot(doc)))
          .toList();
    });
  }
}
