import 'package:flutter/material.dart';
import 'package:tour_management/widgets/widgets.dart';

class GuideCheckPointPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: checkpointAppBar(),
      body: ListCheckPointsGuide(),
    );
  }
}
