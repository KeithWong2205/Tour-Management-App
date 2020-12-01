import 'package:flutter/material.dart';
import 'package:tour_participant/models/student_repo/firebase_student_service.dart';

Widget appBarMain(BuildContext context, {String title = "",List<Widget> actions}) {
  return AppBar(
    title: Text(title, style: biggerTextStyle(),),
    actions: actions,
    elevation: 0.0,
    centerTitle: false,
  );
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white54),
      focusedBorder:
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder:
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
}

TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.black, fontSize: 16);
}

TextStyle biggerTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 17);
}

AppBar chatAppBar() {
  return AppBar(
      title: Text(
        'Chat Panel',
        style: TextStyle(fontSize: 24),
      ),
      backgroundColor: Colors.blue);
}