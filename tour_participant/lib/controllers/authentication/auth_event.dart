import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

//Events on authentication
@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

//When the app started
class AppStarted extends AuthEvent {
  @override
  String toString() => 'App Started';
}

//When user is logged in
class LoggedIn extends AuthEvent {
  @override
  String toString() => 'User Logged In';
}

//When user is logged out
class LoggedOut extends AuthEvent {
  @override
  String toString() => 'User Logged Out';
}
