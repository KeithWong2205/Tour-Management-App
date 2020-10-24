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
      body: Center(
        child: RaisedButton(
            onPressed: () =>
                BlocProvider.of<AuthBloc>(context).add(LoggedOut())),
      ),
    );
  }
}
