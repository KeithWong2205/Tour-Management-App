import 'package:flutter/material.dart';
import 'package:tour_management/widgets/widgets.dart';

class ManagerCheckPointPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: managerCheckpointAppbar(),
      body: ListCheckPoints(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/addTodo');
        },
        icon: Icon(Icons.add),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        label: Text('Add C.Point'),
      ),
    );
  }
}
