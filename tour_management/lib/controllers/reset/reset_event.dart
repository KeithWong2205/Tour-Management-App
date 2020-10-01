import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

//Events on reset password
@immutable
abstract class ResetEvent extends Equatable {
  ResetEvent([List props = const []]) : super(props);
}

//Event on recover email changed
class RecoverChanged extends ResetEvent {
  final String recoveremail;
  RecoverChanged({@required this.recoveremail}) : super([recoveremail]);
  @override
  String toString() =>
      'Recover email changed {with recoveremail: $recoveremail}';
}

//Event on submitted
class Submitted extends ResetEvent {
  final String recoveremail;
  Submitted({@required this.recoveremail}) : super([recoveremail]);
  @override
  String toString() => 'Submitted {with recoveremail: $recoveremail}';
}

//Event on button pressed
class ResetPressed extends ResetEvent {
  final String recoveremail;
  ResetPressed({@required this.recoveremail}) : super([recoveremail]);
  @override
  String toString() => 'Reset pressed: {recover: $recoveremail}';
}
