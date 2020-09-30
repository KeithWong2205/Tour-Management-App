import 'package:meta/meta.dart';

//States of reset password scene
@immutable
class ResetState {
  final bool recoverEmailIsValid;
  final bool isSubmitting;
  final bool resetSuccess;
  final bool resetFail;

  bool get isFormValid => recoverEmailIsValid;

  ResetState(
      {@required this.recoverEmailIsValid,
      @required this.isSubmitting,
      @required this.resetSuccess,
      @required this.resetFail});

//Empty state
  factory ResetState.empty() {
    return ResetState(
        recoverEmailIsValid: true,
        isSubmitting: false,
        resetSuccess: false,
        resetFail: false);
  }

//Loading state
  factory ResetState.loading() {
    return ResetState(
        recoverEmailIsValid: true,
        isSubmitting: true,
        resetSuccess: false,
        resetFail: false);
  }

//Success state
  factory ResetState.success() {
    return ResetState(
        recoverEmailIsValid: true,
        isSubmitting: false,
        resetSuccess: true,
        resetFail: false);
  }

//Failure state
  factory ResetState.failure() {
    return ResetState(
        recoverEmailIsValid: true,
        isSubmitting: false,
        resetSuccess: false,
        resetFail: true);
  }

//Update the paramters
  ResetState update({bool isUserValid, bool recoverEmailIsValid}) {
    return copyWith(
        recoverEmailIsValid: recoverEmailIsValid,
        isSubmitting: false,
        resetSuccess: false,
        resetFail: false);
  }

  ResetState copyWith(
      {bool recoverEmailIsValid,
      bool isSubmitting,
      bool resetSuccess,
      bool resetFail}) {
    return ResetState(
        recoverEmailIsValid: recoverEmailIsValid ?? this.recoverEmailIsValid,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        resetSuccess: resetSuccess ?? this.resetSuccess,
        resetFail: resetFail ?? this.resetFail);
  }

  @override
  String toString() => '''ResetState{
    recoverEmailIsValid: $recoverEmailIsValid,
    isSubmitting: $isSubmitting,
    resetSuccess: $resetSuccess,
    resetFail: $resetFail
  }''';
}
