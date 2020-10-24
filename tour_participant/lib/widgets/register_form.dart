import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_participant/controllers/authentication/auth.dart';
import 'package:tour_participant/controllers/register/register.dart';
import 'package:tour_participant/widgets/widgets.dart';
import 'package:tour_participant/styles/styles.dart';

//Widget for the register form
class RegisterForm extends StatefulWidget {
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();
  final TextEditingController _nameField = TextEditingController();
  final TextEditingController _phoneField = TextEditingController();
  RegBloc _regBloc;
  FocusNode email = FocusNode();
  FocusNode password = FocusNode();
  FocusNode phone = FocusNode();
  String _selectedGroup;
  List<String> groupNames = [
    'Group 1',
    'Group 2',
    'Group 3',
    'Group 4',
    'Group 5'
  ];
  bool get isFilled =>
      _emailField.text.isNotEmpty &&
      _passwordField.text.isNotEmpty &&
      _nameField.text.isNotEmpty &&
      _phoneField.text.isNotEmpty;
  bool isRegFormButtonEnabled(RegState state) =>
      state.isFormValid && isFilled && !state.isSubmitting;

//Initial state of the form
  @override
  void initState() {
    super.initState();
    _regBloc = BlocProvider.of<RegBloc>(context);
    _emailField.addListener(_onEmailChanged);
    _passwordField.addListener(_onPasswordChanged);
    _nameField.addListener(_onNameChanged);
    _phoneField.addListener(_onPhoneChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: _regBloc,
        listener: (BuildContext context, RegState state) {
          if (state.isSubmitting) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(registerSnack());
          }
          if (state.regSuccess) {
            BlocProvider.of<AuthBloc>(context).add(LoggedIn());
            Navigator.of(context).pop();
          }
          if (state.regFail) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(failedRegSnack());
          }
        },
        child: BlocBuilder(
            bloc: _regBloc,
            builder: (BuildContext context, RegState state) {
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
                                padding: EdgeInsets.symmetric(vertical: 0),
                                child: Image.asset('assets/logo.png')),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: TextFormField(
                                    controller: _nameField,
                                    decoration: nameFieldStyle(),
                                    autocorrect: false,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (value) =>
                                        FocusScope.of(context)
                                            .requestFocus(phone))),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2),
                              child: TextFormField(
                                focusNode: phone,
                                controller: _phoneField,
                                decoration: phoneFieldStyle(),
                                autocorrect: false,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (value) =>
                                    FocusScope.of(context).requestFocus(email),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2),
                              child: TextFormField(
                                  focusNode: email,
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
                                  onFieldSubmitted: (value) =>
                                      FocusScope.of(context)
                                          .requestFocus(password)),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: DropdownButtonFormField(
                                  decoration: groupSelectorFieldStyle(),
                                  value: _selectedGroup,
                                  items: groupNames.map((groupName) {
                                    return DropdownMenuItem(
                                      value: groupName,
                                      child: Text('$groupName'),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGroup = value;
                                    });
                                  },
                                )),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
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
                                    onFieldSubmitted: (value) =>
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode()))),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: SignUpButton(
                                onPressed: isRegFormButtonEnabled(state)
                                    ? _onSubmitted
                                    : null,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Already have an account?',
                                          style: TextStyle(fontSize: 16)),
                                      PopBackButton()
                                    ]))
                          ])))));
            }));
  }

  @override
  void dispose() {
    _emailField.dispose();
    _passwordField.dispose();
    _nameField.dispose();
    _phoneField.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _regBloc.add(EmailChanged(email: _emailField.text));
  }

  void _onPasswordChanged() {
    _regBloc.add(PasswordChanged(password: _passwordField.text));
  }

  void _onNameChanged() {
    _regBloc.add(NameChanged(name: _nameField.text));
  }

  void _onPhoneChanged() {
    _regBloc.add(PhoneChanged(phone: _phoneField.text));
  }

  void _onSubmitted() {
    _regBloc.add(Submitted(
        email: _emailField.text,
        password: _passwordField.text,
        name: _nameField.text,
        phone: _phoneField.text,
        groupId: _selectedGroup));
    Navigator.of(context).pop();
  }
}
