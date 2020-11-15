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
              Text('Welcome to the IU Operation App'),
              SizedBox(height: 10),
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
