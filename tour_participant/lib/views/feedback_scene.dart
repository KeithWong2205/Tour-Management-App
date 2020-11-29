import 'package:flutter/material.dart';
import 'package:tour_participant/widgets/widgets.dart';

class FeedBackScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: feedbackAppBar(),
      body: FeedBackForm(),
    );
  }
}
