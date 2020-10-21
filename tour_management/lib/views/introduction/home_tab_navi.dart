import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_management/helper/FCMHelper.dart';
import 'package:tour_management/widgets/widgets.dart';
import 'package:tour_management/controllers/authentication/auth.dart';

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
        child: RaisedButton(
            onPressed: () =>
                BlocProvider.of<AuthBloc>(context).add(LoggedOut())),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    FCMHelper.configure(context);
  }
}
