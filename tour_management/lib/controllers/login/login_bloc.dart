import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tour_management/controllers/login/login.dart';
import 'package:tour_management/models/users_repo/users_repo.dart';
import 'package:tour_management/controllers/controllers.dart';

//Business logic bloc of Login
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  FireBaseService firebaseService;

  LoginBloc({@required this.firebaseService})
      : assert(firebaseService != null),
        super(LoginState.empty());

//Debounce stream when email and password input to give time before validation
  @override
  Stream<Transition<LoginEvent, LoginState>> transformEvents(
      Stream<LoginEvent> events,
      TransitionFunction<LoginEvent, LoginState> transitionFunction) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });
    final debounceStream = events.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
        nonDebounceStream.mergeWith([debounceStream]), transitionFunction);
  }

//Using Stream to map events to states
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged) {
      yield* mapEmailChanged(event.email);
    } else if (event is PasswordChanged) {
      yield* mapPasswordChanged(event.password);
    } else if (event is LoginWithEmailPassword) {
      yield* mapLoginWithEmailPassword(
          email: event.email, password: event.password);
    }
  }

  Stream<LoginState> mapEmailChanged(String email) async* {
    yield state.update(emailIsValid: RegExValidator.isValidEmail(email));
  }

  Stream<LoginState> mapPasswordChanged(String password) async* {
    yield state.update(
        passwordIsValid: RegExValidator.isValidPassword(password));
  }

  Stream<LoginState> mapLoginWithEmailPassword(
      {String email, String password}) async* {
    yield LoginState.loading();
    bool isSuccess =
        await firebaseService.signInWithEmailPassword(email, password);
    if (isSuccess) {
      yield LoginState.success();
    } else {
      yield LoginState.failure();
    }
  }
}
