import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

//Events of register scene
@immutable
abstract class RegEvent extends Equatable {
  const RegEvent();
  @override
  List<Object> get props => [];
}

//Event of email change
class EmailChanged extends RegEvent {
  final String email;
  const EmailChanged({@required this.email});
  @override
  List<Object> get props => [email];
  @override
  String toString() => 'Email changed {with email: $email}';
}

//Event of password change
class PasswordChanged extends RegEvent {
  final String password;
  const PasswordChanged({@required this.password});
  @override
  List<Object> get props => [password];
  @override
  String toString() => 'Password changed {with password: $password}';
}

//Event of name change
class NameChanged extends RegEvent {
  final String name;
  const NameChanged({@required this.name});
  @override
  List<Object> get props => [name];
  @override
  String toString() => 'Name changed {with name: $name}';
}

//Event of phone change
class PhoneChanged extends RegEvent {
  final String phone;
  const PhoneChanged({@required this.phone});
  @override
  List<Object> get props => [phone];
  @override
  String toString() => 'Phone changed {with phone: $phone}';
}

//Event on submit
class Submitted extends RegEvent {
  final String email;
  final String password;
  final String name;
  final String phone;
  final String groupId;
  const Submitted(
      {@required this.email,
      @required this.password,
      @required this.name,
      @required this.phone,
      @required this.groupId});
  @override
  List<Object> get props => [email, password, name, phone, groupId];
  @override
  String toString() =>
      'Submitted {with email: $email, password: $password, name: $name, phone: $phone, groupId: $groupId}';
}
