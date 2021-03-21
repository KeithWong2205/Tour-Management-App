import 'package:flutter/material.dart';
import 'package:tour_participant/widgets/widgets.dart';

class CheckpointPageStudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: checkpointAppBar(),
      drawer: MainDrawer(currentIndex: 0),
      body: ListCheckpointsStudent(),
    );
  }
}
