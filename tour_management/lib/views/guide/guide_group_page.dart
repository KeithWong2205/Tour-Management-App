import 'package:flutter/material.dart';
import 'package:tour_management/widgets/widgets.dart';

class GuideGroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Panel'),
      ),
      drawer: MainDrawer(),
    );
  }
}
