import 'package:meta/meta.dart';

//States of login
@immutable
class LoginState {
  final bool emailIsValid;
  final bool passwordIsValid;
  final bool isSubmitting;
  final bool loginSuccess;
  final bool loginFail;

  bool get isFormValid => emailIsValid && passwordIsValid;

  LoginState(
      {@required this.emailIsValid,
      @required this.passwordIsValid,
      @required this.isSubmitting,
      @required this.loginSuccess,
      @required this.loginFail});

//Empty state
  factory LoginState.empty() {
    return LoginState(
        emailIsValid: true,
        passwordIsValid: true,
        isSubmitting: false,
        loginSuccess: false,
        loginFail: false);
  }

//Loading state
  factory LoginState.loading() {
    return LoginState(
        emailIsValid: true,
        passwordIsValid: true,
        isSubmitting: true,
        loginSuccess: false,
        loginFail: false);
  }

//Success state
  factory LoginState.success() {
    return LoginState(
        emailIsValid: true,
        passwordIsValid: true,
        isSubmitting: false,
        loginSuccess: true,
        loginFail: false);
  }

//Failed state
  factory LoginState.failure() {
    return LoginState(
        emailIsValid: true,
        passwordIsValid: true,
        isSubmitting: false,
        loginSuccess: false,
        loginFail: true);
  }

//Update the parameter for validation
  LoginState update({bool emailIsValid, bool passwordIsValid}) {
    return copyWith(
      emailIsValid: emailIsValid,
      passwordIsValid: passwordIsValid,
      isSubmitting: false,
      loginSuccess: false,
      loginFail: false,
    );
  }

  LoginState copyWith(
      {bool emailIsValid,
      bool passwordIsValid,
      bool isSubmitting,
      bool loginSuccess,
      bool loginFail}) {
    return LoginState(
        emailIsValid: emailIsValid ?? this.emailIsValid,
        passwordIsValid: passwordIsValid ?? this.passwordIsValid,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        loginSuccess: loginSuccess ?? this.loginSuccess,
        loginFail: loginFail ?? this.loginFail);
  }

  @override
  String toString() => '''LoginState{
    emailIsValid: $emailIsValid,
    passwordIsValid: $passwordIsValid,
    isSubmitting: $isSubmitting,
    loginSuccess: $loginSuccess,
    loginFail: $loginFail
  }''';
}
