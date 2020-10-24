import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tour_participant/controllers/authentication/auth.dart';
import 'package:tour_participant/models/student_repo/student_repo.dart';

//Business logic bloc of authentication
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseService firebaseService;
  AuthBloc({@required this.firebaseService})
      : assert(firebaseService != null),
        super(Uninitialized());

//Using Stream to map the events to states
  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      yield* mapAppStarted();
    } else if (event is LoggedIn) {
      yield* mapLoggedIn();
    } else if (event is LoggedOut) {
      yield* mapLoggedOut();
    }
  }

  Stream<AuthState> mapAppStarted() async* {
    try {
      final isSignedIn = await firebaseService.signedInStatus();
      if (isSignedIn) {
        final email = await firebaseService.getUser();
        yield Authenticated(email);
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthState> mapLoggedIn() async* {
    yield Authenticated(await firebaseService.getUser());
  }

  Stream<AuthState> mapLoggedOut() async* {
    yield Unauthenticated();
    firebaseService.signOutUser();
  }
}
