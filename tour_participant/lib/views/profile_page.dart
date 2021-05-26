import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_participant/controllers/authentication/auth.dart';
import 'package:tour_participant/helper/SharedPreferencesHelper.dart';
import 'package:tour_participant/models/student_repo/student_repo.dart';
import 'package:tour_participant/styles/animation.dart';
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
      backgroundColor: Colors.grey[350],
      drawer: MainDrawer(currentIndex: 2),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile Panel", style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.amber,
        actions: [
          // ignore: deprecated_member_use
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
                width: MediaQuery.of(context).size.width,
              ),
              Positioned(
                child: (_currUser?.photoURL != null &&
                        _currUser.photoURL.isNotEmpty)
                    ? CircleAvatar(
                        radius: MediaQuery.of(context).size.height / 7,
                        backgroundImage: NetworkImage(_currUser.photoURL),
                        backgroundColor: Colors.grey,
                      )
                    : CircleAvatar(
                        radius: MediaQuery.of(context).size.height / 7,
                        backgroundColor: Colors.grey,
                      ),
              )
            ]),
            SizedBox(height: 20),
            Card(
              child: ListTile(
                leading: Icon(Icons.person, color: Colors.amber),
                title: Text("Name",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.amber)),
                subtitle: Text(_currUser?.name ?? "",
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
                subtitle: Text(_currUser?.phone ?? "",
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
                subtitle: Text(_currUser?.email ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
            )
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              SlideTopRoute(
                  page: ProfileEditPage(
                userModel: _currUser,
              ))).then((value) {
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
