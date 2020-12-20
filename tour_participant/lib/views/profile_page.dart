import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_participant/controllers/authentication/auth.dart';
import 'package:tour_participant/helper/SharedPreferencesHelper.dart';
import 'package:tour_participant/models/student_repo/student_repo.dart';
import 'package:tour_participant/views/views.dart';
import 'package:tour_participant/widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel _currUser;

  @override
  void initState() {
    super.initState();
    AppDataHelper.getUser().then((savedUser) {
      setState(() {
        _currUser = savedUser;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        title: Text("Profile Panel", style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.amber,
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.of(context).popUntil(ModalRoute.withName('/'));
                BlocProvider.of<AuthBloc>(context).add(LoggedOut());
              },
              child: Icon(
                Icons.exit_to_app,
                size: 26,
                color: Colors.white,
              ))
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            SizedBox(height: 50),
            Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: (_currUser?.photoURL != null &&
                          _currUser.photoURL.isNotEmpty)
                      ? CircleAvatar(
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(_currUser.photoURL),
                          radius: 150,
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 150,
                        ),
                )),
            SizedBox(height: 20),
            Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text(_currUser?.name ?? ""),
              ),
            ),
            SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: Icon(Icons.phone),
                title: Text(_currUser?.phone ?? ""),
              ),
            ),
            SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: Icon(Icons.mail),
                title: Text(_currUser?.email ?? ""),
              ),
            )
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (_) => ProfileEditPage(
                        userModel: _currUser,
                      )))
              .then((value) {
            FireStoreService().getStudent(_currUser.id).then((value) {
              AppDataHelper.setUser(value);
              setState(() {
                _currUser = value;
              });
            });
          });
        },
        label: Text("Edit"),
        icon: Icon(Icons.edit),
        backgroundColor: Colors.amber,
      ),
    );
  }
}
