import 'package:flutter/material.dart';
import 'package:tour_management/widgets/manager_related/list_group_manager.dart';
import 'package:tour_management/widgets/widgets.dart';

class ManagerGroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Group Panel'),
      ),
      drawer: MainDrawer(),
      body: ListGroupManager(),
    );
  }
}
