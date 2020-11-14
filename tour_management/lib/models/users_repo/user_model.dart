//Model for a user in firestore
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tour_management/models/users_repo/users_repo.dart';

enum VisibilityGroupFilter { all, guide, participant }

@immutable
class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String groupID;
  final String role;
  final String photoURL;
  UserModel(
      {String id,
      String name = '',
      String email = '',
      String phone = '',
      String groupID = '',
      String role = '',
      String photoURL,
  })
      : this.id = id,
        this.name = name ?? '',
        this.email = email ?? '',
        this.phone = phone ?? '',
        this.groupID = groupID ?? '0',
        this.role = role ?? 'guide',
        this.photoURL = photoURL ?? ''
  ;

  //Passing the parameters
  UserModel copyWith(
      {String id,
      String name,
      String email,
      String phone,
      String groupID,
      String role,
      String photoURL,
      }) {
    return UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        groupID: groupID ?? this.groupID,
        role: role ?? this.role,
        photoURL: photoURL ?? this.photoURL
    );
  }

//Get hashcode
  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      groupID.hashCode ^
      role.hashCode;
//== operator override
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          phone == other.phone &&
          groupID == other.groupID &&
          role == other.role;

  //Convert to entity
  UserEntity toEntity() {
    return UserEntity(id, name, email, phone, groupID, role, photoURL);
  }

  //Get model from entity
  static UserModel fromEntity(UserEntity entity) {
    return UserModel(
        id: entity.id,
        name: entity.name,
        email: entity.email,
        phone: entity.phone,
        groupID: entity.groupID,
        photoURL: entity.photoURL,
        role: entity.role);
  }

  //Get user's data from the data collection from firestore
  UserModel.fromData(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        email = data['email'],
        phone = data['phone'],
        groupID = data['groupID'],
        role = data['role'],
        photoURL = data['photoURL'];

  //Check if is manager
  bool isManager() {
    return role == "manager";
  }
}
