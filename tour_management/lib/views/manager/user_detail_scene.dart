import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_management/controllers/group_manager/group_man.dart';

class UserDetailScene extends StatefulWidget {
  final String id;

  UserDetailScene({@required this.id, Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _UserDetailSceneState();
}

class _UserDetailSceneState extends State<UserDetailScene> {
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
            backgroundColor: Colors.grey[350],
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'User Detail',
                style: TextStyle(fontSize: 24),
              ),
              backgroundColor: Colors.green,
            ),
            body: user == null
                ? Container()
                : Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Stack(alignment: Alignment.center, children: <Widget>[
                            Image(
                              image: AssetImage('assets/groupgrad.jpg'),
                              height: MediaQuery.of(context).size.height / 3,
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width,
                            ),
                            Positioned(
                              child: (user.photoURL != null &&
                                      user.photoURL.isNotEmpty)
                                  ? CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.height /
                                              7,
                                      backgroundImage:
                                          NetworkImage(user.photoURL),
                                      backgroundColor: Colors.grey,
                                    )
                                  : CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.height /
                                              7,
                                      backgroundColor: Colors.grey,
                                    ),
                            )
                          ]),
                          SizedBox(height: 20),
                          Card(
                            child: ListTile(
                                leading: Icon(
                                  Icons.person,
                                  color: Colors.green,
                                ),
                                title: Text(
                                  "User's Name",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.green),
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
                          Card(
                            child: ListTile(
                              leading: Icon(
                                Icons.group,
                                color: Colors.green,
                              ),
                              title: Text(
                                'Attendee Group',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.green),
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
                          Card(
                            child: ListTile(
                              leading: Icon(
                                Icons.email,
                                color: Colors.green,
                              ),
                              title: Text(
                                'Email',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.green),
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
                          Card(
                            child: ListTile(
                              leading: Icon(
                                Icons.phone,
                                color: Colors.green,
                              ),
                              title: Text(
                                'Phone Number',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.green),
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
                        ],
                      ),
                    ),
                  ));
      },
    );
  }
}
