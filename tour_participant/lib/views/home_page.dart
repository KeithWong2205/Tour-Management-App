import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_participant/widgets/widgets.dart';
import 'package:tour_participant/controllers/authentication/auth.dart';

//Home screen where there is a bottom tab navi
class HomeTabNavi extends StatefulWidget {
  @override
  State<HomeTabNavi> createState() => _HomeTabNaviState();
}

class _HomeTabNaviState extends State<HomeTabNavi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: welcomeAppBar(),
      drawer: MainDrawer(),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: ListView(
            children: [
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image(
                    height: MediaQuery.of(context).size.height / 3,
                    fit: BoxFit.fill,
                    image: AssetImage('assets/welcome.png'),
                  )
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Welcome to the IU Campus Tour App',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'This app was designed and implemented with the purpose of enhancing the tour experience for the participant of the IU Ambassador Campus Tour program',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'You can view your provided tour plan as a list of checkpoints. Create your very own profile and chat with others. We also hope that you would choose to provide your valuable feedback to the tour and the applications',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '<<-- Get started by tapping on the drawer on the left',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
