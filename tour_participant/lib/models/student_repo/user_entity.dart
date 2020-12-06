import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

//Class for user entity
class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String groupID;
  final String role;
  final String photoURL;

  const UserEntity(
      this.id, this.name, this.email, this.phone, this.groupID, this.role, this.photoURL);
  @override
  List<Object> get props => [id, name, email, phone, groupID, role, photoURL];

  @override
  String toString() =>
      'User entity created $id, $name, $email, $phone, $groupID, $role, $photoURL';

  //Mapping the entity to Json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'groupID': groupID,
      'role': role,
      'photoURL' : photoURL,
    };
  }

  //Get entity from Json
  static UserEntity fromJson(Map<String, dynamic> json) {
    return UserEntity(
        json['id'] as String,
        json['name'] as String,
        json['email'] as String,
        json['phone'] as String,
        json['groupID'] as String,
        json['role'] as String,
        json['photoURL'] as String
    );
  }

  //Get entity from snapshot
  static UserEntity fromSnapshot(DocumentSnapshot snapshot) {
    return UserEntity(
        snapshot.data()['id'],
        snapshot.data()['name'],
        snapshot.data()['email'],
        snapshot.data()['phone'],
        snapshot.data()['groupID'],
        snapshot.data()['role'],
        snapshot.data()['photoURL']
    );
  }

  //Map user entity to firestore document
  Map<String, Object> toDocument() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'groupID': groupID,
      'role': role,
      'photoURL' : photoURL
    };
  }
}
