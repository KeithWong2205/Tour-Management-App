import 'package:flutter/material.dart';
import 'package:tour_management/models/users_repo/users_repo.dart';
import 'package:tour_management/views/profile_page.dart';
import 'package:tour_management/views/conversation/chat_room.dart';

//The drawer for every scene
class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.blue,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.only(top: 45, bottom: 15),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('assets/drawer.png'),
                              fit: BoxFit.fill))),
                  Text(
                    'Tour Operator Team',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Card(
              child: ListTile(
                  leading: Icon(
                    Icons.done_all,
                    color: Colors.red,
                  ),
                  title: Text(
                    'Checkpoints',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                  subtitle: Text('View your planned itinerary'),
                  onTap: () =>
                      FireBaseService().checkRoleCheckpointUser(context))),
          Card(
              child: ListTile(
            leading: Icon(
              Icons.people,
              color: Colors.green,
            ),
            title: Text(
              'Attendee Group',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            subtitle: Text('View information of your group'),
            onTap: () => FireBaseService().checkRoleGroupUser(context),
          )),
          Card(
              child: ListTile(
            leading: Icon(
              Icons.chat_bubble,
              color: Colors.blue,
            ),
            title: Text(
              'Conversation',
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            subtitle: Text('Chat with guides & manager'),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ChatRoom())),
          )),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.amber,
              ),
              title: Text(
                'Profile',
                style: TextStyle(fontSize: 18, color: Colors.amber),
              ),
              subtitle: Text('View your own profile'),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ProfilePage())),
            ),
          ),
        ],
      ),
    );
  }
}

class CheckpointDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.blue,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.only(top: 45, bottom: 15),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('assets/drawer.png'),
                              fit: BoxFit.fill))),
                  Text(
                    'Tour Operator Team',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Card(
              child: ListTile(
            leading: Icon(
              Icons.people,
              color: Colors.green,
            ),
            title: Text(
              'Attendee Group',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            subtitle: Text('View information of your group'),
            onTap: () => FireBaseService().checkRoleGroupUser(context),
          )),
          Card(
              child: ListTile(
            leading: Icon(
              Icons.chat_bubble,
              color: Colors.blue,
            ),
            title: Text(
              'Conversation',
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            subtitle: Text('Chat with guides & manager'),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ChatRoom())),
          )),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.amber,
              ),
              title: Text(
                'Profile',
                style: TextStyle(fontSize: 18, color: Colors.amber),
              ),
              subtitle: Text('View your own profile'),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ProfilePage())),
            ),
          ),
        ],
      ),
    );
  }
}

class GroupDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.blue,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.only(top: 45, bottom: 15),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('assets/drawer.png'),
                              fit: BoxFit.fill))),
                  Text(
                    'Tour Operator Team',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Card(
              child: ListTile(
                  leading: Icon(
                    Icons.done_all,
                    color: Colors.red,
                  ),
                  title: Text(
                    'Checkpoints',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                  subtitle: Text('View your planned itinerary'),
                  onTap: () =>
                      FireBaseService().checkRoleCheckpointUser(context))),
          Card(
              child: ListTile(
            leading: Icon(
              Icons.chat_bubble,
              color: Colors.blue,
            ),
            title: Text(
              'Conversation',
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            subtitle: Text('Chat with guides & manager'),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ChatRoom())),
          )),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.amber,
              ),
              title: Text(
                'Profile',
                style: TextStyle(fontSize: 18, color: Colors.amber),
              ),
              subtitle: Text('View your own profile'),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ProfilePage())),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.blue,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.only(top: 45, bottom: 15),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('assets/drawer.png'),
                              fit: BoxFit.fill))),
                  Text(
                    'Tour Operator Team',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Card(
              child: ListTile(
                  leading: Icon(
                    Icons.done_all,
                    color: Colors.red,
                  ),
                  title: Text(
                    'Checkpoints',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                  subtitle: Text('View your planned itinerary'),
                  onTap: () =>
                      FireBaseService().checkRoleCheckpointUser(context))),
          Card(
              child: ListTile(
            leading: Icon(
              Icons.people,
              color: Colors.green,
            ),
            title: Text(
              'Attendee Group',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            subtitle: Text('View information of your group'),
            onTap: () => FireBaseService().checkRoleGroupUser(context),
          )),
          Card(
              child: ListTile(
            leading: Icon(
              Icons.chat_bubble,
              color: Colors.blue,
            ),
            title: Text(
              'Conversation',
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            subtitle: Text('Chat with guides & manager'),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ChatRoom())),
          )),
        ],
      ),
    );
  }
}

class ChatDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.blue,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.only(top: 45, bottom: 15),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('assets/drawer.png'),
                              fit: BoxFit.fill))),
                  Text(
                    'Tour Operator Team',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Card(
              child: ListTile(
                  leading: Icon(
                    Icons.done_all,
                    color: Colors.red,
                  ),
                  title: Text(
                    'Checkpoints',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                  subtitle: Text('View your planned itinerary'),
                  onTap: () =>
                      FireBaseService().checkRoleCheckpointUser(context))),
          Card(
              child: ListTile(
            leading: Icon(
              Icons.people,
              color: Colors.green,
            ),
            title: Text(
              'Attendee Group',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            subtitle: Text('View information of your group'),
            onTap: () => FireBaseService().checkRoleGroupUser(context),
          )),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.amber,
              ),
              title: Text(
                'Profile',
                style: TextStyle(fontSize: 18, color: Colors.amber),
              ),
              subtitle: Text('View your own profile'),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ProfilePage())),
            ),
          ),
        ],
      ),
    );
  }
}
