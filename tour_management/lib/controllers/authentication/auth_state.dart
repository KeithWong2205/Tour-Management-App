import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

//States of authentication
@immutable
abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

//State of uninitialize
class Uninitialized extends AuthState {
  @override
  String toString() => 'Uninitialized';
}

//State of authenticated aka logged in
class Authenticated extends AuthState {
  final String displayName;
  const Authenticated(this.displayName);
  @override
  List<Object> get props => [displayName];
  @override
  String toString() => 'Authenticated {with displayName: $displayName}';
}

//State of unauthenticated aka logged out
class Unauthenticated extends AuthState {
  @override
  String toString() => 'Unauthenticated';
}
