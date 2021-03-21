import 'package:flutter/material.dart';

InputDecoration emailFieldStyle() {
  return InputDecoration(
      filled: true,
      fillColor: Colors.white.withOpacity(0.3),
      icon: Icon(
        Icons.mail,
        color: Colors.blue,
        size: 28,
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
        Icons.person,
        color: Colors.redAccent,
        size: 28,
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
        color: Colors.green,
        size: 28,
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
        color: Colors.amber,
        size: 28,
      ),
      hintText: 'Enter your password',
      labelText: 'Password',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)));
}

InputDecoration groupSelectorFieldStyle() {
  return InputDecoration(
      filled: true,
      fillColor: Colors.white.withOpacity(0.3),
      icon: Icon(
        Icons.people,
        color: Colors.black,
        size: 28,
      ),
      hintText: 'Enter your phone',
      labelText: 'Group Selector',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)));
}

InputDecoration feedbackFormFieldStyle() {
  return InputDecoration(
      filled: true,
      fillColor: Colors.red[200].withOpacity(0.3),
      hintText: 'Put your thoughts here',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)));
}

InputDecoration profileNameFieldStyle() {
  return InputDecoration(
      filled: true,
      fillColor: Colors.amber[200].withOpacity(0.3),
      icon: Icon(
        Icons.person,
        color: Colors.amber,
      ),
      hintText: 'Please give a brief name',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)));
}

InputDecoration profilePhoneFieldStyle() {
  return InputDecoration(
      filled: true,
      fillColor: Colors.amber[200].withOpacity(0.3),
      icon: Icon(
        Icons.phone,
        color: Colors.amber,
      ),
      hintText: 'Please give a phone number',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)));
}
