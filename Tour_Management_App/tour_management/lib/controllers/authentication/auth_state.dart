import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

//States of authentication
@immutable
abstract class AuthState extends Equatable {
  AuthState([List props = const []]) : super(props);
}

//State of uninitialize
class Uninitialized extends AuthState {
  @override
  String toString() => 'Uninitialized';
}

//State of authenticated aka logged in
class Authenticated extends AuthState {
  final String displayName;
  Authenticated(this.displayName) : super([displayName]);
  @override
  String toString() => 'Authenticated {with displayName: $displayName}';
}

//State of unauthenticated aka logged out
class Unauthenticated extends AuthState {
  @override
  String toString() => 'Unauthenticated';
}
