import 'package:flutter/material.dart';
import 'package:tour_participant/widgets/widgets.dart';

class CheckpointPageStudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: checkpointAppBar(),
      drawer: MainDrawer(currentIndex: 0),
      body: ListCheckpointsStudent(),
    );
  }
}
