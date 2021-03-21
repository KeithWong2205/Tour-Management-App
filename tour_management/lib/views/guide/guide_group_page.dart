import 'package:flutter/material.dart';
import 'package:tour_management/widgets/widgets.dart';

class GuideGroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: groupAppBar(),
      drawer: GroupDrawer(),
      body: ListGroupGuide(),
    );
  }
}
