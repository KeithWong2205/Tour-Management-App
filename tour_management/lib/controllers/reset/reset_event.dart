import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

//Events on reset password
@immutable
abstract class ResetEvent extends Equatable {
  const ResetEvent();
  @override
  List<Object> get props => [];
}

//Event on recover email changed
class RecoverChanged extends ResetEvent {
  final String recoveremail;
  const RecoverChanged({@required this.recoveremail});
  @override
  List<Object> get props => [recoveremail];
  @override
  String toString() =>
      'Recover email changed {with recoveremail: $recoveremail}';
}

//Event on submitted
class Submitted extends ResetEvent {
  final String recoveremail;
  const Submitted({@required this.recoveremail});
  @override
  List<Object> get props => [recoveremail];
  @override
  String toString() => 'Submitted {with recoveremail: $recoveremail}';
}

//Event on button pressed
class ResetPressed extends ResetEvent {
  final String recoveremail;
  const ResetPressed({@required this.recoveremail});
  @override
  List<Object> get props => [recoveremail];
  @override
  String toString() => 'Reset pressed: {recover: $recoveremail}';
}
