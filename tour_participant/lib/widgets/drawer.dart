import 'package:flutter/material.dart';
import 'package:tour_participant/views/views.dart';

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
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CheckpointPageStudent())))),
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
            ),
          )
        ],
      ),
    );
  }
}
