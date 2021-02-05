import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:feedback_repo/feedback_repo.dart';
import 'package:meta/meta.dart';
import 'package:tour_participant/controllers/feedback_manager/feedback_man.dart';
import 'package:tour_participant/helper/SharedPreferencesHelper.dart';

//Checkpoint business bloc
class FeedbackManBloc extends Bloc<FeedbackManEvent, FeedbackManState> {
  final FirebaseFeedbackService firebaseFeedbackService;
  StreamSubscription _feedbackSubscription;
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
    if (event is FeedbackListManUpdate) {
      yield* mapFeedbackListManUpdate(event);
    }
  }

  Stream<FeedbackManState> mapFeedbackManLoaded({String groupId}) async* {
    _feedbackSubscription?.cancel();
    _feedbackSubscription = firebaseFeedbackService
        .feedbackList()
        .listen((feedbackList) => add(FeedbackListManUpdate(feedbackList)));
  }

  Stream<FeedbackManState> mapFeedbackManAdded(FeedbackManAdded event) async* {
    firebaseFeedbackService.addNewFeedback(event.feedback);
  }

  Stream<FeedbackManState> mapFeedbackManUpdated(
      FeedbackManUpdated event) async* {
    firebaseFeedbackService.updateFeedback(event.updated);
  }

  Stream<FeedbackManState> mapFeedbackListManUpdate(
      FeedbackListManUpdate event) async* {
    yield FeedbackManLoadSuccess(event.updatedList);

    @override
    // ignore: unused_element
    Future<void> close() {
      _feedbackSubscription?.cancel();
      return super.close();
    }
  }
}
