import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tour_participant/models/student_repo/student_repo.dart';
import 'package:tour_participant/controllers/register/register.dart';
import 'package:tour_participant/controllers/controllers.dart';

//Business logic bloc for registration
class RegBloc extends Bloc<RegEvent, RegState> {
  final FirebaseService firebaseService;
  RegBloc({@required this.firebaseService})
      : assert(firebaseService != null),
        super(RegState.empty());

//Debounce stream when email and password input to give time before validation
  @override
  Stream<Transition<RegEvent, RegState>> transformEvents(
      Stream<RegEvent> events,
      TransitionFunction<RegEvent, RegState> transitionFunction) {
    final nonDebounceStream = events.where(
        (event) => (event is! EmailChanged && event is! PasswordChanged));
    final debounceStream = events
        .where((event) => (event is EmailChanged || event is PasswordChanged))
        .debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
        nonDebounceStream.mergeWith([debounceStream]), transitionFunction);
  }

//Using Stream to map events to states
  @override
  Stream<RegState> mapEventToState(RegEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChanged(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChanged(event.password);
    } else if (event is Submitted) {
      yield* _mapRegFormSubmitted(
          email: event.email,
          password: event.password,
          name: event.name,
          phone: event.phone);
    }
  }

  Stream<RegState> _mapEmailChanged(String email) async* {
    yield state.update(emailIsValid: RegExValidator.isValidEmail(email));
  }

  Stream<RegState> _mapPasswordChanged(String password) async* {
    yield state.update(
        passwordIsValid: RegExValidator.isValidPassword(password));
  }

  Stream<RegState> _mapRegFormSubmitted(
      {String email, String password, String name, String phone}) async* {
    yield RegState.loading();
    try {
      await firebaseService.signUpNewUser(
          email: email, password: password, name: name, phone: phone);
      yield RegState.success();
    } catch (_) {
      yield RegState.failure();
    }
  }
}
