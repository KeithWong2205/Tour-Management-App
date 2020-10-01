import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

//Events of login
@immutable
abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

//When the email is changed
class EmailChanged extends LoginEvent {
  final String email;
  EmailChanged({@required this.email}) : super([email]);

  @override
  String toString() => 'Email is changed {with email: $email}';
}

//When the password is changed
class PasswordChanged extends LoginEvent {
  final String password;
  PasswordChanged({@required this.password}) : super([password]);

  @override
  String toString() => 'Password is changes {with password: $password}';
}

//When the login form is submitted
class Submitted extends LoginEvent {
  final String email;
  final String password;
  Submitted({@required this.email, @required this.password})
      : super([email, password]);

  @override
  String toString() =>
      'Login form submitted {email: $email, password: $password}';
}

//When user press the login button
class LoginWithEmailPassword extends LoginEvent {
  final String email;
  final String password;
  LoginWithEmailPassword({@required this.email, @required this.password})
      : super([email, password]);

  @override
  String toString() => 'Login pressed {email: $email, password: $password}';
}
