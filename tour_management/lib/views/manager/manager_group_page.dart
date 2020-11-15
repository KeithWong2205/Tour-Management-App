import 'package:flutter/material.dart';
import 'package:tour_management/widgets/widgets.dart';

class ManagerGroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: groupAppBar(),
      drawer: GroupDrawer(),
      body: ListGroupManager(),
    );
  }
}
