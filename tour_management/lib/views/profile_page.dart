import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_management/controllers/authentication/auth.dart';
import 'package:tour_management/helper/AppDataHelper.dart';
import 'package:tour_management/models/users_repo/firestore_service.dart';
import 'package:tour_management/models/users_repo/user_model.dart';
import 'package:tour_management/styles/animation.dart';
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
      backgroundColor: Colors.grey[350],
      drawer: ProfileDrawer(),
      appBar: AppBar(
        centerTitle: true,
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
              Stack(alignment: Alignment.center, children: <Widget>[
                Image(
                  height: MediaQuery.of(context).size.height / 3,
                  fit: BoxFit.fill,
                  image: AssetImage('assets/profgrad.jpg'),
                ),
                Positioned(
                  child: (_currentUser?.photoURL != null &&
                          _currentUser.photoURL.isNotEmpty)
                      ? CircleAvatar(
                          radius: MediaQuery.of(context).size.height / 7,
                          backgroundImage: NetworkImage(_currentUser.photoURL),
                          backgroundColor: Colors.grey,
                        )
                      : CircleAvatar(
                          radius: MediaQuery.of(context).size.height / 7,
                          backgroundColor: Colors.grey,
                        ),
                )
              ]),
              SizedBox(
                height: 20,
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.person, color: Colors.amber),
                  title: Text("Name",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.amber)),
                  subtitle: Text(_currentUser?.name ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.phone, color: Colors.amber),
                  title: Text("Phone",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.amber)),
                  subtitle: Text(_currentUser?.phone ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.mail, color: Colors.amber),
                  title: Text("Email",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.amber)),
                  subtitle: Text(_currentUser?.email ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              SlideTopRoute(
                  page: ProfileEditScene(
                userModel: _currentUser,
              ))).then((value) {
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
