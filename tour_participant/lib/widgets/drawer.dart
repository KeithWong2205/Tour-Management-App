import 'package:flutter/material.dart';
import 'package:tour_participant/views/conversation/chat_room.dart';
import 'package:tour_participant/views/views.dart';

//The drawer for every scene
class MainDrawer extends StatelessWidget {
  static const int MENU_ITEM_COUNT = 3;
  final int currentIndex;

  const MainDrawer({Key key, this.currentIndex}) : super(key: key);

  Widget header() {
    return Container(
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
              'Tour Participant Team',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget checkpoint(BuildContext context) {
    return Card(
      color: Colors.red[200],
      child: ListTile(
          leading: Icon(
            Icons.done_all,
            color: Colors.black,
          ),
          title: Text(
            'Checkpoints',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          subtitle: Text('View your planned itinerary'),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CheckpointPageStudent()))),
    );
  }

  Widget conversation(BuildContext context) {
    return Card(
      color: Colors.blue[200],
      child: ListTile(
          leading: Icon(
            Icons.chat_bubble,
            color: Colors.black,
          ),
          title: Text(
            'Conversation',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          subtitle: Text('Chat with guides & manager'),
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ChatRoom()))),
    );
  }

  Widget profile(BuildContext context) {
    return Card(
      color: Colors.amber[200],
      child: ListTile(
        leading: Icon(
          Icons.person,
          color: Colors.black,
        ),
        title: Text(
          'Profile',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        subtitle: Text('View your own profile'),
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ProfilePage())),
      ),
    );
  }

  Widget listItem({Widget listTitle}) {
    return Card(
      child: listTitle,
    );
  }

  List<Widget> generateDrawerItems(BuildContext context) {
    List<Widget> widgets = List();
    widgets.add(header());
    List<Widget> menuItems = List();
    menuItems.add(listItem(listTitle: checkpoint(context)));
    menuItems.add(listItem(listTitle: conversation(context)));
    menuItems.add(listItem(listTitle: profile(context)));
    if (currentIndex != null &&
        currentIndex >= 0 &&
        currentIndex < MENU_ITEM_COUNT) {
      menuItems.removeAt(currentIndex);
    }
    widgets.addAll(menuItems);
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: generateDrawerItems(context),
      ),
    );
  }
}
