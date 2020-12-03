import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:chpnt_repo_manager/chpnt_repo_manager.dart';
import 'package:feedback_repo/feedback_repo.dart';
import 'package:tour_management/controllers/chpnt_manager/chpnt_man.dart';
import 'package:tour_management/controllers/chpoint_list/chpoint_list.dart';
import 'package:tour_management/controllers/feedback_list/feedback_list.dart';
import 'package:tour_management/controllers/feedback_manager/feedback_man.dart';

//Business bloc for checkpoint list
class FeedbackListBloc
    extends Bloc<FeedbackListEvent, FeedbackListState> {
  final FeedbackManBloc feedbackManBloc;
  StreamSubscription feedbackSubscription;
  FeedbackListBloc({@required this.feedbackManBloc})
      : super(feedbackManBloc.state is FeedbackManLoadSuccess
            ? FeedbackListLoaded(
                (feedbackManBloc.state as FeedbackManLoadSuccess)
                    .feedbackList)
            : FeedbackListLoading()) {
    feedbackSubscription = feedbackManBloc.listen((state) {
      if (state is FeedbackManLoadSuccess) {
        add(FeedbackListUpdated(
            (feedbackManBloc.state as FeedbackManLoadSuccess).feedbackList));
      }
    });
  }

  @override
  Stream<FeedbackListState> mapEventToState(
      FeedbackListEvent event) async* {
    if (event is FeedbackListUpdated) {
      yield* _mapFeedbackListUpdated(event);
    }
  }

  Stream<FeedbackListState> _mapFeedbackListUpdated(FeedbackListUpdated event) async* {
    yield FeedbackListLoaded(
        _mapFeedbackToFilter((feedbackManBloc.state as FeedbackManLoadSuccess).feedbackList));
  }

  List<FeedbackModel> _mapFeedbackToFilter(List<FeedbackModel> feedbackList) {
    return feedbackList.toList();
  }

  @override
  Future<void> close() {
    feedbackSubscription?.cancel();
    return super.close();
  }
}
