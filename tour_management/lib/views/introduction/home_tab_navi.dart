import 'package:flutter/material.dart';
import 'package:tour_management/helper/AppDataHelper.dart';
import 'package:tour_management/helper/FCMHelper.dart';
import 'package:tour_management/widgets/widgets.dart';

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
                    image: AssetImage('assets/cover.jpg'),
                  )
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Welcome to the IU Operation App',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'This app was designed and implemented with the purpose of enhancing the tour leading experience and assessment for both the guide and the manager staffs',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    FCMHelper.configure(context);
    AppDataHelper.getUser().then((user) => {
          FCMHelper.subscribe(topic: user.groupID),
          FCMHelper.subscribe(topic: user.id),
        });
  }
}
