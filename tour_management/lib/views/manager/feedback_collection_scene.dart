import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:tour_management/controllers/feedback_list/feedback_list.dart';
import 'package:tour_management/views/views.dart';
import 'package:tour_management/widgets/app_bars.dart';
import 'package:tour_management/widgets/widgets.dart';

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
        return GroupedListView(
          elements: feedbackList,
          groupBy: (element) => element.ratingOverall,
          groupComparator: (value1, value2) => value2.compareTo(value1),
          itemComparator: (element1, element2) =>
              element1.userName.compareTo(element2.userName),
          order: GroupedListOrder.ASC,
          useStickyGroupSeparators: true,
          groupSeparatorBuilder: (value) => Container(
            color: Colors.red[50],
            height: 80,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 2,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border.all(color: Colors.grey[100]),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: RatingBarIndicator(
                    rating: value,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 30,
                    direction: Axis.horizontal,
                  ),
                ),
              ),
            ),
          ),
          itemBuilder: (context, element) {
            return FeedbackItem(
                onTap: () =>
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return FeedbackDetailScene(
                        id: element.feedbackID,
                      );
                    })),
                feedbackModel: element);
          },
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    });
  }
}
