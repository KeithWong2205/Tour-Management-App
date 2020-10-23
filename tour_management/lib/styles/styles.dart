import 'package:flutter/material.dart';

InputDecoration emailFieldStyle() {
  return InputDecoration(
      filled: true,
      fillColor: Colors.white.withOpacity(0.3),
      icon: Icon(
        Icons.mail,
        color: Colors.white,
      ),
      hintText: 'Enter your email',
      labelText: 'Email',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)));
}

InputDecoration nameFieldStyle() {
  return InputDecoration(
      filled: true,
      fillColor: Colors.white.withOpacity(0.3),
      icon: Icon(
        Icons.people,
        color: Colors.white,
      ),
      hintText: 'Enter your name',
      labelText: 'Name',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)));
}

InputDecoration phoneFieldStyle() {
  return InputDecoration(
      filled: true,
      fillColor: Colors.white.withOpacity(0.3),
      icon: Icon(
        Icons.phone,
        color: Colors.white,
      ),
      hintText: 'Enter your phone',
      labelText: 'Phone',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)));
}

InputDecoration passswordFieldStyle() {
  return InputDecoration(
      filled: true,
      fillColor: Colors.white.withOpacity(0.3),
      icon: Icon(
        Icons.lock,
        color: Colors.white,
      ),
      hintText: 'Enter your password',
      labelText: 'Password',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)));
}

InputDecoration checkpointNameFieldStyle() {
  return InputDecoration(
      filled: true,
      fillColor: Colors.white.withOpacity(0.3),
      icon: Icon(
        Icons.card_membership,
        color: Colors.black,
      ),
      hintText: 'Please give a brief name',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)));
}

InputDecoration checkpointLocationFieldStyle() {
  return InputDecoration(
      filled: true,
      fillColor: Colors.white.withOpacity(0.3),
      icon: Icon(
        Icons.add_location,
        color: Colors.black,
      ),
      hintText: 'Where is this place?',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)));
}

InputDecoration checkpointDateTimeFieldStyle() {
  return InputDecoration(
      filled: true,
      fillColor: Colors.white.withOpacity(0.3),
      icon: Icon(
        Icons.calendar_today,
        color: Colors.black,
      ),
      hintText: 'Tap to select a date & time',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)));
}

InputDecoration checkpointGroupFieldStyle() {
  return InputDecoration(
      filled: true,
      fillColor: Colors.white.withOpacity(0.3),
      icon: Icon(
        Icons.people,
        color: Colors.black,
      ),
      hintText: 'Tap to select group',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)));
}

InputDecoration checkpointNoteFieldStyle() {
  return InputDecoration(
      filled: true,
      fillColor: Colors.white.withOpacity(0.3),
      icon: Icon(
        Icons.note,
        color: Colors.black,
      ),
      hintText: 'Do we have any notes?',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)));
}
