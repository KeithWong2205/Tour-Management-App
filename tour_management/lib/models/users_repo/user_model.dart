//Model for a user in firestore
class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String groupID;
  final String role;

  UserModel(
      {this.id, this.name, this.email, this.phone, this.groupID, this.role});

  //Get user's data from the data collection from firestore
  UserModel.fromData(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        email = data['email'],
        phone = data['phone'],
        groupID = data['groupID'],
        role = data['role'];

  //Map a user to Json to send to firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'groupID': groupID,
      'role': role,
    };
  }

  bool isManager() {
    return role == "manager";
  }
}
