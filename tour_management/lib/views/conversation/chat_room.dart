import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tour_management/helper/AppDataHelper.dart';
import 'package:tour_management/models/users_repo/firebase_service.dart';
import 'package:tour_management/views/conversation/helperfunctions.dart';
import 'package:tour_management/views/conversation/search.dart';

import 'chat.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Stream chatRooms;
  String _userId = "";

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
            itemCount: snapshot.data.documents != null ? snapshot.data.documents.length : 0,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ChatRoomsTile(
                userName: snapshot.data.documents[index].data()['name'],
                chatRoomId: HelperFunctions.createChatRoomId(
                    snapshot.data.documents[index].data()['id']
                    , _userId
                ),
              );
            })
            : Container();
      },
    );
  }

  @override
  void initState() {
    final currentUser = AppDataHelper.getUser();
    currentUser.then((value) =>  getUserInfogetChats(value.id));
    super.initState();
  }

  getUserInfogetChats(String uid) async {
    // _userName = await HelperFunctions.getUserNameSharedPreference();
    _userId = uid;
    FireBaseService().getUserChats().then((snapshots) {
      setState(() {
        chatRooms = Stream<QuerySnapshot>.value(snapshots);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Image.asset(
        //   "assets/images/logo.png",
        //   height: 40,
        // ),
        elevation: 0.0,
        centerTitle: false,
      ),
      body: Container(
        child: chatRoomsList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Search(currentUid: _userId)));
        },
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({this.userName,@required this.chatRoomId});

   Future handleOnCreateChatRoom(BuildContext context) async {
    List<String> users = chatRoomId.split('_');
    users.sort();
    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId" : chatRoomId,
    };
    await FireBaseService().addChatRoom(chatRoom, chatRoomId);
  }

  Future<void> handleOnOpenChat(BuildContext context) async {
    final chatRoomRef = Firestore.instance.collection('chatRoom').document(chatRoomId);
    final snapshot = await chatRoomRef.get();
    if(!snapshot.exists){
      await handleOnCreateChatRoom(context);
    }
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => Chat(chatRoomId: chatRoomId, )));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => handleOnOpenChat(context),
      child: Card(
        child:  Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Row(
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Color(0xff007EF4),
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Text(userName.substring(0, 1),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'OverpassRegular',
                          fontWeight: FontWeight.w300)),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Text(userName,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'OverpassRegular',
                      fontWeight: FontWeight.w300))
            ],
          ),
        ),
      ),
    );
  }
}