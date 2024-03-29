import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tour_participant/helper/FCMHelper.dart';
import 'package:tour_participant/helper/SharedPreferencesHelper.dart';
import 'package:tour_participant/views/conversation/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tour_participant/models/student_repo/firebase_student_service.dart';

class Chat extends StatefulWidget {
  final String chatRoomId;
  final String receiverId;
  final String receiverName;
  final String receiverPhone;
  Chat(
      {this.chatRoomId,
      this.receiverId,
      this.receiverName,
      this.receiverPhone});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = new TextEditingController();
  ScrollController _scrollController = new ScrollController();
  String _userId = "";
  String _userName = "";

  Widget chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot) {
        // _scrollToEnd();
        return snapshot.hasData
            ? ListView.builder(
                controller: _scrollController,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                    message: snapshot.data.documents[index].data()["message"],
                    sendByMe: _userId ==
                        snapshot.data.documents[index].data()["sendBy"],
                  );
                })
            : Container();
      },
    );
  }

  addMessage() {
    var message = messageEditingController.text;
    if (message.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": _userId,
        "message": message,
        'time': DateTime.now().millisecondsSinceEpoch,
      };

      FirebaseService().addMessage(widget.chatRoomId, chatMessageMap);
      if (widget.receiverId.isNotEmpty) {
        FCMHelper.sendMessage(
            message: message,
            title: _userName ?? "Unknown User",
            to: '/topics/' + widget.receiverId);
      }
      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  void handleInitChatInfo(User user) {
    _userId = user.uid;
    AppDataHelper.getUser().then((userData) => {_userName = userData.name});
  }

  // void _scrollToEnd() async {
  //   Future.delayed(Duration(milliseconds: 200), () {
  //     _scrollController.animateTo(_scrollController.position.maxScrollExtent,
  //         duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  //   });
  // }

  @override
  void dispose() {
    FCMHelper.clearIgnoreTitle();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    handleInitChatInfo(FirebaseAuth.instance.currentUser);
    FirebaseService().getChats(widget.chatRoomId).then((val) {
      setState(() {
        chats = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    FCMHelper.updateIgnoreTitle(title: widget.receiverName);
    return Scaffold(
      appBar: appBarMain(context, title: widget.receiverName ?? "", actions: [
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                _launchCaller(this.widget.receiverPhone);
              },
              child: Icon(
                Icons.phone,
                size: 26.0,
                color: Colors.amber,
              ),
            )),
      ]),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: chatMessages(),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                color: Colors.blue[100],
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                            height: 48.0,
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24.0),
                                border: Border.all(
                                    color: Colors.white70, width: 2.0)),
                            child: Center(
                              child: TextField(
                                cursorWidth: 2.0,
                                cursorColor: Colors.black,
                                controller: messageEditingController,
                                style: simpleTextStyle(),
                                decoration: InputDecoration(
                                    hintText: "Message ...",
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    border: InputBorder.none),
                              ),
                            ))),
                    SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        addMessage();
                      },
                      child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(40)),
                          padding: EdgeInsets.all(12),
                          child: Image.asset(
                            "assets/send.png",
                            height: 25,
                            width: 25,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchCaller(String phone) async {
    var url = "tel:" + phone;
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({@required this.message, @required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    final double radius = 24.0;
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 12, bottom: 12, left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          color: sendByMe ? Colors.blue : Colors.green,
        ),
        child: Text(message ?? "",
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w400)),
      ),
    );
  }
}
