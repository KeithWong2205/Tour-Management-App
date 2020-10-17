import 'package:flutter/material.dart';
import 'package:tour_management/widgets/list_checkpoint.dart';

class GuideCheckPointPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guide here'),
      ),
      body: ListCheckPoints(),
    );
  }
}
