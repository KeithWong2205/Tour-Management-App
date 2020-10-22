import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FCMHelper {

  static final FCMHelper _instance = FCMHelper._internal();

  FirebaseMessaging _firebaseMessaging;
  
  final String serverToken = 'AAAAalMccjc:APA91bEbJGk5CE8Cfs6Kiotzdggld2b4kBohXdE1L2H-24kS2XQTfsZF8zef08UaTvH4jJx-qROwJmE1Uu8JWarIw3UAKjgGha4iA8FpJpQQOa9yfHzafqEvlyFwzFvx6aKqRQUxijqx';

  /// MARK: Constructor
  factory FCMHelper() {
    return _instance;
  }

  FCMHelper._internal();

  /// MARK: Action functions
  static Future<void> configure(BuildContext context) async {
    var _firebaseMessaging = _instance.getFirebaseMessaging();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("HTB95-onMessage: $message");
        var _notification = message['notification'];
        _instance.handleShowLocalNotification(
          context: context,
          message: _notification['body'] ?? '',
          title: _notification['title'] ?? '',
        );
      },
      onBackgroundMessage: (Map<String, dynamic> message) {
        print("HTB95-onBackgroundMessage: $message");
        return _instance.handleBackgroundMessage(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("HTB95-onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("HTB95-onResume: $message");
      },
    );
  }

  static void sendMessage({String message, String title, String to}) async {
    await _instance.getFirebaseMessaging().requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
    );
    var _serverToken = _instance.serverToken;
    var _to = to;
    if (_to.startsWith('/topics/')) {
      _to = _to.replaceAll(' ', '-');
    }
    var result = await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$_serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': message ?? '',
            'title': title ?? ''
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': _to ?? '',
        },
      ),
    );
    print('Result: ' + result.toString());
  }

  static subscribe({String topic}) {
    var _topic = topic.replaceAll(' ', '-');
    _instance.getFirebaseMessaging().subscribeToTopic(_topic);
  }

  /// MARK: Getter functions
  FirebaseMessaging getFirebaseMessaging() {
    if (_firebaseMessaging == null) {
      _firebaseMessaging = FirebaseMessaging();
    }
    return _firebaseMessaging;
  }

  /// MARK: Handle functions
  Future<dynamic> handleBackgroundMessage(Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  void handleShowLocalNotification({BuildContext context, String message, String title}) {
    showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
          actions: [
            FlatButton(
              child: Text("OK"),
              onPressed: () => {
                Navigator.of(context).pop()
              },
            ),
          ],
          content: new Text(message),
          title: new Text(title),
        )
    );
  }
}