import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tour_management/controllers/reset/reset.dart';
import 'package:tour_management/controllers/controllers.dart';
import 'package:tour_management/models/users_repo/users_repo.dart';

//Business logic bloc for reset password
class ResetBloc extends Bloc<ResetEvent, ResetState> {
  final FireBaseService firebaseService;
  ResetBloc({@required this.firebaseService})
      : assert(firebaseService != null),
        super(ResetState.empty());

//Debounce stream when email and password input to give time before validation
  @override
  Stream<Transition<ResetEvent, ResetState>> transformEvents(
      Stream<ResetEvent> events,
      TransitionFunction<ResetEvent, ResetState> transitionFunction) {
    final nonDebounceStream =
        events.where((event) => (event is! RecoverChanged));
    final debounceStream = events
        .where((event) => (event is RecoverChanged))
        .debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
        nonDebounceStream.mergeWith([debounceStream]), transitionFunction);
  }

//Using Stream to map events to states
  @override
  Stream<ResetState> mapEventToState(ResetEvent event) async* {
    if (event is RecoverChanged) {
      yield* _mapRecoverEmailChanged(event.recoveremail);
    } else if (event is Submitted) {
      yield* _mapSubmitted(event.recoveremail);
    }
  }

  Stream<ResetState> _mapRecoverEmailChanged(String recoveremail) async* {
    yield state.update(
      recoverEmailIsValid: RegExValidator.isValidEmail(recoveremail),
    );
  }

  Stream<ResetState> _mapSubmitted(String recoveremail) async* {
    yield ResetState.loading();
    try {
      await firebaseService.resetPassword(recoveremail);
      yield ResetState.success();
    } catch (_) {
      yield ResetState.failure();
    }
  }
}
