import 'package:feedback_repo/feedback_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FeedbackItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final FeedbackModel feedbackModel;

  FeedbackItem({@required this.onTap, @required this.feedbackModel});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: Icon(Icons.tab, color: Colors.amber),
        title: Hero(
            tag: '${feedbackModel.userName}__heroTag',
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Text(feedbackModel.userName,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            )),
        subtitle: Text('Tap to see more details...'),
        trailing: Icon(Icons.navigate_next),
      ),
    );
  }
}
