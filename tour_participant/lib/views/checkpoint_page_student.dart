import 'package:flutter/material.dart';
import 'package:tour_participant/widgets/widgets.dart';

class CheckpointPageStudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: checkpointAppBar(),
      body: ListCheckpointsStudent(),
    );
  }
}
