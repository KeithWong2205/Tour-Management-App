import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_participant/controllers/authentication/auth.dart';
import 'package:tour_participant/controllers/login/login.dart';
import 'package:tour_participant/styles/styles.dart';
import 'package:tour_participant/widgets/widgets.dart';
import 'package:tour_participant/models/student_repo/student_repo.dart';

//Building Login form widget
class LoginForm extends StatefulWidget {
  final FirebaseService firebaseService;
  LoginForm({Key key, @required this.firebaseService})
      : assert(firebaseService != null),
        super(key: key);
  State<LoginForm> createState() => _LoginFormState();
}

//Declaration of LoginForm and initial state
class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();
  FocusNode password = FocusNode();
  LoginBloc _loginBloc;
  FirebaseService get _users => widget.firebaseService;
  bool get isFilled =>
      _emailField.text.isNotEmpty && _passwordField.text.isNotEmpty;
  bool loginButtonEnabled(LoginState state) =>
      state.isFormValid && isFilled && !state.isSubmitting;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailField.addListener(_onEmailChanged);
    _passwordField.addListener(_onPasswordChanged);
  }

//Building the login form with form field and buttons
  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: _loginBloc,
        listener: (BuildContext context, LoginState state) {
          if (state.loginFail) {
            Scaffold.of(context)
              // ignore: deprecated_member_use
              ..hideCurrentSnackBar()
              // ignore: deprecated_member_use
              ..showSnackBar(failedLoginSnack());
          }
          if (state.isSubmitting) {
            Scaffold.of(context)
              // ignore: deprecated_member_use
              ..hideCurrentSnackBar()
              // ignore: deprecated_member_use
              ..showSnackBar(loginSnack());
          }
          if (state.loginSuccess) {
            BlocProvider.of<AuthBloc>(context).add(LoggedIn());
          }
        },
        child: BlocBuilder(
            bloc: _loginBloc,
            builder: (BuildContext context, LoginState state) {
              return Container(
                  color: Colors.white,
                  child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: GestureDetector(
                          onTap: () => FocusScope.of(context)
                              .requestFocus(new FocusNode()),
                          child: Form(
                              child: ListView(children: <Widget>[
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Image.asset('assets/logo.png')),
                            SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: TextFormField(
                                controller: _emailField,
                                decoration: emailFieldStyle(),
                                // ignore: deprecated_member_use
                                autovalidate: true,
                                autocorrect: false,
                                textInputAction: TextInputAction.next,
                                validator: (_) {
                                  return !state.emailIsValid
                                      ? 'Invalid email'
                                      : null;
                                },
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context).requestFocus(password);
                                },
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                  focusNode: password,
                                  controller: _passwordField,
                                  decoration: passswordFieldStyle(),
                                  autocorrect: false,
                                  obscureText: true,
                                  // ignore: deprecated_member_use
                                  autovalidate: true,
                                  textInputAction: TextInputAction.done,
                                  validator: (_) {
                                    return !state.passwordIsValid
                                        ? 'Wrong password'
                                        : null;
                                  },
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                  },
                                )),
                            SizedBox(
                              height: 40,
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: LoginButton(
                                  onPressed: loginButtonEnabled(state)
                                      ? _onFormSubmitted
                                      : null,
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: ForgotPassButton(firebaseService: _users),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Don't have an account?",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      RegisterButton(firebaseService: _users)
                                    ]))
                          ])))));
            }));
  }

  @override
  void dispose() {
    _emailField.dispose();
    _passwordField.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.add(EmailChanged(email: _emailField.text));
  }

  void _onPasswordChanged() {
    _loginBloc.add(PasswordChanged(password: _passwordField.text));
  }

  void _onFormSubmitted() {
    _loginBloc.add(LoginWithEmailPassword(
        email: _emailField.text, password: _passwordField.text));
  }
}
