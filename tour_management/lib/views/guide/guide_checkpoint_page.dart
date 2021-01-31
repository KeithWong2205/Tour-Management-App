import 'package:flutter/material.dart';
import 'package:tour_management/widgets/widgets.dart';

class GuideCheckPointPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: checkpointAppBar(),
      drawer: CheckpointDrawer(),
      body: ListCheckPointsGuide(),
    );
  }
}
