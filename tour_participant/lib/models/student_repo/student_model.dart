//Model for student in firestore
class Student {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String groupID;
  final String role;

  Student(
      {this.id, this.name, this.email, this.phone, this.groupID, this.role});

  //Get student model data from firestore data
  Student.fromData(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        email = data['email'],
        phone = data['phone'],
        groupID = data['groupID'],
        role = data['role'];

  //Map student data to Json to send to firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'groupID': groupID,
      'role': role
    };
  }
}
