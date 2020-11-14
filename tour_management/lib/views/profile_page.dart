import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_management/controllers/authentication/auth.dart';
import 'package:tour_management/helper/AppDataHelper.dart';
import 'package:tour_management/models/users_repo/firestore_service.dart';
import 'package:tour_management/models/users_repo/user_model.dart';
import 'package:tour_management/views/views.dart';
import 'package:tour_management/widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel _currentUser;

  @override
  void initState() {
    super.initState();
    AppDataHelper.getUser().then((savedUser) {
      setState(() {
        _currentUser = savedUser;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      drawer: MainDrawer(),
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
                  child: (_currentUser?.photoURL != null &&
                          _currentUser.photoURL.isNotEmpty)
                      ? CircleAvatar(
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(_currentUser.photoURL),
                          radius: 150,
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 150,
                        ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text(_currentUser?.name ?? ""),
                ),
              ),
              SizedBox(height: 10),
              Card(
                child: ListTile(
                  leading: Icon(Icons.phone),
                  title: Text(_currentUser?.phone ?? ""),
                ),
              ),
              SizedBox(height: 10),
              Card(
                child: ListTile(
                  leading: Icon(Icons.mail),
                  title: Text(_currentUser?.email ?? ""),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (_) => ProfileEditScene(
                        userModel: _currentUser,
                      )))
              .then((value) {
            FireStoreService().getUser(_currentUser.id).then((value) {
              AppDataHelper.setUser(value);
              setState(() {
                _currentUser = value;
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
