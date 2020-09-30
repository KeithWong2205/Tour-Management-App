import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_repository/user_repository.dart';

//Firestore service for handling user data
class FireStoreService {
  final CollectionReference _userCollectionReference =
      Firestore.instance.collection('users');

  //Create user in the collection
  Future createUser(UserModel userModel) async {
    await _userCollectionReference
        .document(userModel.id)
        .setData(userModel.toJson());
  }

  //Get user from collection
  Future getUser(String uid) async {
    try {
      var userData = await _userCollectionReference.document(uid).get();
      return UserModel.fromData(userData.data);
    } catch (e) {
      return e.message;
    }
  }
}
