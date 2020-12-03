import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:feedback_repo/feedback_repo.dart';
import 'package:meta/meta.dart';
import 'package:chpnt_repo_manager/chpnt_repo_manager.dart';
import 'package:tour_management/controllers/feedback_manager/feedback_man.dart';
import 'package:tour_management/helper/AppDataHelper.dart';

//Checkpoint business bloc
class FeedbackManBloc extends Bloc<FeedbackManEvent, FeedbackManState> {
  final FirebaseFeedbackService firebaseFeedbackService;
  StreamSubscription _checkpointSubscription;
  FeedbackManBloc({@required this.firebaseFeedbackService})
      : assert(firebaseFeedbackService != null),
        super(FeedbackManLoading());

//Using stream to map events to states
  @override
  Stream<FeedbackManState> mapEventToState(FeedbackManEvent event) async* {
    if (event is FeedbackManLoaded) {
      var _user = await AppDataHelper.getUser();
      var _groupId = _user.groupID;
      yield* mapFeedbackManLoaded(groupId: _groupId);
    }
    if (event is FeedbackManAdded) {
      yield* mapFeedbackManAdded(event);
    }
    if (event is FeedbackManUpdated) {
      yield* mapFeedbackManUpdated(event);
    }
    if (event is FeedbackManDelete) {
      yield* mapFeedbackManDelete(event);
    }
    if (event is FeedbackListManUpdate) {
      yield* mapFeedbackListManUpdate(event);
    }
  }

  Stream<FeedbackManState> mapFeedbackManLoaded({String groupId}) async* {
    _checkpointSubscription?.cancel();
    _checkpointSubscription = firebaseFeedbackService
        .feedbackList()
        .listen((feedbackList) => add(FeedbackListManUpdate(feedbackList)));
  }

  Stream<FeedbackManState> mapFeedbackManAdded(
      FeedbackManAdded event) async* {
    firebaseFeedbackService.addNewFeedback(event.feedback);
  }

  Stream<FeedbackManState> mapFeedbackManUpdated(
      FeedbackManUpdated event) async* {
    firebaseFeedbackService.updateCheckpoint(event.updated);
  }

  Stream<FeedbackManState> mapFeedbackManDelete(
      FeedbackManDelete event) async* {
    firebaseFeedbackService.deleteCheckpoint(event.deleted);
  }

  Stream<FeedbackManState> mapFeedbackListManUpdate(
      FeedbackListManUpdate event) async* {
    yield FeedbackManLoadSuccess(event.updatedList);

    @override
    // ignore: unused_element
    Future<void> close() {
      _checkpointSubscription?.cancel();
      return super.close();
    }
  }
}
