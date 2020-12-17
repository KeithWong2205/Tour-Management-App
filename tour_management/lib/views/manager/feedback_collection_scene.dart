import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_management/controllers/feedback_list/feedback_list.dart';
import 'package:tour_management/widgets/app_bars.dart';

class FeedBackCollectionScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: feedbackAppBar(),
      body: ListFeedbacksManager(),
    );
  }
}

class ListFeedbacksManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedbackListBloc, FeedbackListState>(
        builder: (context, state) {
      if (state is FeedbackListLoaded) {
        final feedbackList = state.feedbackList;
        return ListView.builder(
          itemCount: feedbackList.length,
          itemBuilder: (context, index) => Text(feedbackList[index].userName),
        );
      } else {
        return Container();
      }
    });
  }
}
