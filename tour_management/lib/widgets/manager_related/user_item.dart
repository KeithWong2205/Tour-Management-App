import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tour_management/models/users_repo/users_repo.dart';

class UserItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final UserModel user;
  UserItem({Key key, @required this.user, @required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 50,
        ),
        title: Hero(
          tag: '${user.name}__heroTag',
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(user.name,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ),
        ),
        subtitle: Text(
          user.email,
          style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: Colors.blueAccent),
        ),
      ),
    );
  }
}
