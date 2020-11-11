import 'package:flutter/material.dart';
import 'package:tour_management/views/views.dart';
import 'package:tour_management/widgets/widgets.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: profileAppBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 50),
              Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 150,
                    child: Text("Profile Picture"),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Profile name"),
                ),
              ),
              SizedBox(height: 10),
              Card(
                child: ListTile(
                  leading: Icon(Icons.phone),
                  title: Text("Phone"),
                ),
              ),
              SizedBox(height: 10),
              Card(
                child: ListTile(
                  leading: Icon(Icons.mail),
                  title: Text("Mail"),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => ProfileEditScene()));
        },
        label: Text("Edit Profile"),
        icon: Icon(Icons.edit),
        backgroundColor: Colors.amber,
      ),
    );
  }
}
