import 'package:meta/meta.dart';

//State of register scene
@immutable
class RegState {
  final bool emailIsValid;
  final bool passwordIsValid;
  final bool isSubmitting;
  final bool regSuccess;
  final bool regFail;

  bool get isFormValid => emailIsValid && passwordIsValid;

  RegState(
      {@required this.emailIsValid,
      @required this.passwordIsValid,
      @required this.isSubmitting,
      @required this.regSuccess,
      @required this.regFail});

//Empty state
  factory RegState.empty() {
    return RegState(
        emailIsValid: true,
        passwordIsValid: true,
        isSubmitting: false,
        regSuccess: false,
        regFail: false);
  }

//Loading state
  factory RegState.loading() {
    return RegState(
        emailIsValid: true,
        passwordIsValid: true,
        isSubmitting: true,
        regSuccess: false,
        regFail: false);
  }

//Success state
  factory RegState.success() {
    return RegState(
        emailIsValid: true,
        passwordIsValid: true,
        isSubmitting: false,
        regSuccess: true,
        regFail: false);
  }

//Failure state
  factory RegState.failure() {
    return RegState(
        emailIsValid: true,
        passwordIsValid: true,
        isSubmitting: false,
        regSuccess: false,
        regFail: true);
  }

//Update the parameters
  RegState update({bool emailIsValid, bool passwordIsValid}) {
    return copyWith(
        emailIsValid: emailIsValid,
        passwordIsValid: passwordIsValid,
        isSubmitting: isSubmitting,
        regSuccess: regSuccess,
        regFail: regFail);
  }

  RegState copyWith(
      {bool emailIsValid,
      bool passwordIsValid,
      bool isSubmitting,
      bool regSuccess,
      bool regFail}) {
    return RegState(
        emailIsValid: emailIsValid ?? this.emailIsValid,
        passwordIsValid: passwordIsValid ?? this.passwordIsValid,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        regSuccess: regSuccess ?? this.regSuccess,
        regFail: regFail ?? this.regFail);
  }

  @override
  String toString() => '''Regiter State{
    emailIsValid: $emailIsValid,
    passwordIsValid: $passwordIsValid,
    isSubmitting: $isSubmitting,
    regSuccess: $regSuccess,
    regFail: $regFail
  }''';
}
