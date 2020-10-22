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
