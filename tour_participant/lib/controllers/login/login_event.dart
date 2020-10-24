import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

//Events of login
@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

//When the email is changed
class EmailChanged extends LoginEvent {
  final String email;
  const EmailChanged({@required this.email});
  @override
  List<Object> get props => [email];
  @override
  String toString() => 'Email is changed {with email: $email}';
}

//When the password is changed
class PasswordChanged extends LoginEvent {
  final String password;
  const PasswordChanged({@required this.password});
  @override
  List<Object> get props => [password];
  @override
  String toString() => 'Password is changes {with password: $password}';
}

//When the login form is submitted
class Submitted extends LoginEvent {
  final String email;
  final String password;
  const Submitted({@required this.email, @required this.password});
  @override
  List<Object> get props => [email, password];
  @override
  String toString() =>
      'Login form submitted {email: $email, password: $password}';
}

//When user press the login button
class LoginWithEmailPassword extends LoginEvent {
  final String email;
  final String password;
  const LoginWithEmailPassword({@required this.email, @required this.password});
  @override
  List<Object> get props => [email, password];
  @override
  String toString() => 'Login pressed {email: $email, password: $password}';
}
