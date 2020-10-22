import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_participant/controllers/authentication/auth.dart';
import 'package:tour_participant/controllers/reset/reset.dart';
import 'package:tour_participant/widgets/widgets.dart';
import 'package:tour_participant/styles/styles.dart';

//Widget for the form for reset password
class ResetForm extends StatefulWidget {
  State<ResetForm> createState() => _ResetFormState();
}

class _ResetFormState extends State<ResetForm> {
  final TextEditingController _recoverField = TextEditingController();
  ResetBloc _resetBloc;
  bool get isFilled => _recoverField.text.isNotEmpty;
  bool isResetButtonEnabled(ResetState state) =>
      state.isFormValid && isFilled && !state.isSubmitting;

//Initial state of the form
  @override
  void initState() {
    super.initState();
    _resetBloc = BlocProvider.of<ResetBloc>(context);
    _recoverField.addListener(_onRecoverEmailChanged);
  }

//Building the widget for the reset form
  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: _resetBloc,
        listener: (BuildContext context, ResetState state) {
          if (state.isSubmitting) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(resetSnack());
          }
          if (state.resetFail) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(failedResetSnack());
          }
          if (state.resetSuccess) {
            BlocProvider.of<AuthBloc>(context).add(LoggedOut());
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder(
            bloc: _resetBloc,
            builder: (BuildContext context, ResetState state) {
              return Container(
                  color: Colors.blue,
                  child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: GestureDetector(
                          onTap: () => FocusScope.of(context)
                              .requestFocus(new FocusNode()),
                          child: Form(
                              child: ListView(children: <Widget>[
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 25),
                                child: Image.asset('assets/logo.png')),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                controller: _recoverField,
                                decoration: emailFieldStyle(),
                                // ignore: deprecated_member_use
                                autovalidate: true,
                                autocorrect: false,
                                textInputAction: TextInputAction.next,
                                validator: (_) {
                                  return !state.recoverEmailIsValid
                                      ? 'Invalid email'
                                      : null;
                                },
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: ResetButton(
                                onTapped: isResetButtonEnabled(state)
                                    ? _onSubmitted
                                    : null,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Remember your password?',
                                          style: TextStyle(fontSize: 16)),
                                      PopBackButton()
                                    ]))
                          ])))));
            }));
  }

  @override
  void dispose() {
    _recoverField.dispose();
    super.dispose();
  }

  void _onRecoverEmailChanged() {
    _resetBloc.add(RecoverChanged(recoveremail: _recoverField.text));
  }

  void _onSubmitted() {
    _resetBloc.add(Submitted(recoveremail: _recoverField.text));
  }
}
