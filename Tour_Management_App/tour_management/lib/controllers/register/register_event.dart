import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

//Events of register scene
@immutable
abstract class RegEvent extends Equatable {
  RegEvent([List props = const []]) : super(props);
}

//Event of email change
class EmailChanged extends RegEvent {
  final String email;
  EmailChanged({@required this.email}) : super([email]);
  @override
  String toString() => 'Email changed {with email: $email}';
}

//Event of password change
class PasswordChanged extends RegEvent {
  final String password;
  PasswordChanged({@required this.password}) : super([password]);
  @override
  String toString() => 'Password changed {with password: $password}';
}

//Event of name change
class NameChanged extends RegEvent {
  final String name;
  NameChanged({@required this.name}) : super([name]);
  @override
  String toString() => 'Name changed {with name: $name}';
}

//Event of phone change
class PhoneChanged extends RegEvent {
  final String phone;
  PhoneChanged({@required this.phone}) : super([phone]);
  @override
  String toString() => 'Phone changed {with phone: $phone}';
}

//Event on submit
class Submitted extends RegEvent {
  final String email;
  final String password;
  final String name;
  final String phone;
  Submitted({
    @required this.email,
    @required this.password,
    @required this.name,
    @required this.phone,
  }) : super([email, password, name, phone]);
  @override
  String toString() =>
      'Submitted {with email: $email, password: $password, name: $name, phone: $phone}';
}
