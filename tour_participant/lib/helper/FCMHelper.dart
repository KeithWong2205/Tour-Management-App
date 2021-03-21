import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:overlay_support/overlay_support.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    // final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    // final dynamic notification = message['notification'];
  }

  // Or do other work.
}

class FCMHelper {
  static final FCMHelper _instance = FCMHelper._internal();

  FirebaseMessaging _firebaseMessaging;
  String _ignoreTitle = "";

  final String serverToken =
      'AAAAalMccjc:APA91bEbJGk5CE8Cfs6Kiotzdggld2b4kBohXdE1L2H-24kS2XQTfsZF8zef08UaTvH4jJx-qROwJmE1Uu8JWarIw3UAKjgGha4iA8FpJpQQOa9yfHzafqEvlyFwzFvx6aKqRQUxijqx';

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
        var _notification = message['notification'];
        _instance.handleShowLocalNotification(
          context: context,
          message: _notification['body'] ?? '',
          title: _notification['title'] ?? '',
        );
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  static clearIgnoreTitle() {
    updateIgnoreTitle(title: "");
  }

  static void sendMessage({String message, String title, String to}) async {
    await _instance.getFirebaseMessaging().requestNotificationPermissions(
          const IosNotificationSettings(
              sound: true, badge: true, alert: true, provisional: false),
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

  static unsubscribe({String topic}) {
    var _topic = topic.replaceAll(' ', '-');
    _instance.getFirebaseMessaging().unsubscribeFromTopic(_topic);
  }

  static updateIgnoreTitle({String title}) {
    _instance._ignoreTitle = title;
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
      // ignore: unused_local_variable
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // ignore: unused_local_variable
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  void handleShowLocalNotification(
      {BuildContext context, String message, String title}) {
    if (title != _instance._ignoreTitle) {
      /*     Fluttertoast.showToast(
        msg: title + ": " + message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0); */
      // showDialog(
      //     context: context,
      //     builder: (_) => new CupertinoAlertDialog(
      //           actions: [
      //             FlatButton(
      //               child: Text("OK"),
      //               onPressed: () => {Navigator.of(context).pop()},
      //             ),
      //           ],
      //           content: new Text(message),
      //           title: new Text(title),
      //         ));
      showOverlayNotification((context) {
        return Card(
          color: Colors.blue,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: SafeArea(
            child: ListTile(
              leading: SizedBox.fromSize(
                  size: const Size(40, 40),
                  child: ClipOval(
                      child: Icon(
                    Icons.warning,
                    color: Colors.amber,
                  ))),
              title: new Text(title),
              subtitle: new Text(message),
              trailing: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    OverlaySupportEntry.of(context).dismiss();
                  }),
            ),
          ),
        );
      }, duration: Duration(milliseconds: 4000));
    }
  }
}
