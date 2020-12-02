import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_management/controllers/group_manager/group_man.dart';

class UserChatDetailScene extends StatefulWidget {
  final String id;

  UserChatDetailScene({@required this.id, Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _UserChatDetailSceneState();
}

class _UserChatDetailSceneState extends State<UserChatDetailScene> {
  // ignore: unused_field
  String _photoUrl;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupManBloc, GroupManState>(
      builder: (context, state) {
        final user = (state as GroupManLoadSuccess)
            .users
            .firstWhere((user) => user.id == widget.id, orElse: null);
        return Scaffold(
            appBar: AppBar(
              title: Text(
                'User Detail',
                style: TextStyle(fontSize: 24),
              ),
              backgroundColor: Colors.blue,
            ),
            body: user == null
                ? Container()
                : Container(
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 300,
                            child: (user.photoURL != null &&
                                    user.photoURL.isNotEmpty)
                                ? CircleAvatar(
                                    radius: 250,
                                    backgroundImage:
                                        NetworkImage(user.photoURL),
                                    backgroundColor: Colors.grey,
                                  )
                                : CircleAvatar(
                                    radius: 250,
                                    backgroundColor: Colors.grey,
                                  ),
                          ),
                          SizedBox(height: 40),
                          Card(
                            child: ListTile(
                                leading: Icon(
                                  Icons.person,
                                  color: Colors.blue,
                                ),
                                title: Text(
                                  "User's Name",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.blue),
                                ),
                                subtitle: Text(
                                  user.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                            child: ListTile(
                              leading: Icon(
                                Icons.group,
                                color: Colors.blue,
                              ),
                              title: Text(
                                'Attendee Group',
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(fontSize: 16, color: Colors.blue),
                              ),
                              subtitle: Text(
                                user.groupID,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                            child: ListTile(
                              leading: Icon(
                                Icons.email,
                                color: Colors.blue,
                              ),
                              title: Text(
                                'Email',
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(fontSize: 16, color: Colors.blue),
                              ),
                              subtitle: Text(
                                user.email,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                            child: ListTile(
                              leading: Icon(
                                Icons.phone,
                                color: Colors.blue,
                              ),
                              title: Text(
                                'Phone Number',
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(fontSize: 16, color: Colors.blue),
                              ),
                              subtitle: Text(
                                user.phone,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ));
      },
    );
  }
}
