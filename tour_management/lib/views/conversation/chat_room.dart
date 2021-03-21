import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tour_management/models/users_repo/firebase_service.dart';
import 'package:tour_management/styles/animation.dart';
import 'package:tour_management/views/conversation/helperfunctions.dart';
import 'package:tour_management/views/conversation/search.dart';
import 'package:tour_management/widgets/widgets.dart';
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
                itemCount: snapshot.data.documents != null
                    ? snapshot.data.documents.length
                    : 0,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                    userName: snapshot.data.documents[index].data()['name'],
                    chatRoomId: HelperFunctions.createChatRoomId(
                        snapshot.data.documents[index].data()['id'], _userId),
                    isCurrentUser:
                        snapshot.data.documents[index].data()['id'] == _userId,
                    receiverId: snapshot.data.documents[index].data()['id'],
                    receiverPhone:
                        snapshot.data.documents[index].data()['phone'],
                  );
                })
            : Container();
      },
    );
  }

  @override
  void initState() {
    _userId = FirebaseAuth.instance.currentUser.uid;
    FireBaseService().getUserChats().then((snapshots) {
      setState(() {
        chatRooms = Stream<QuerySnapshot>.value(snapshots);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: chatAppBar(),
      drawer: ChatDrawer(),
      body: Container(
        child: chatRoomsList(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.search),
        label: Text("Search"),
        onPressed: () {
          Navigator.push(
              context, SlideTopRoute(page: Search(currentUid: _userId)));
        },
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  final String receiverId;
  final String receiverPhone;

  final bool isCurrentUser;

  ChatRoomsTile(
      {this.userName,
      @required this.chatRoomId,
      @required this.isCurrentUser,
      @required this.receiverId,
      @required this.receiverPhone});

  Future handleOnCreateChatRoom(BuildContext context) async {
    List<String> users = chatRoomId.split('_');
    users.sort();
    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId": chatRoomId,
    };
    await FireBaseService().addChatRoom(chatRoom, chatRoomId);
  }

  Future<void> handleOnOpenChat(BuildContext context) async {
    final chatRoomRef =
        FirebaseFirestore.instance.collection('chatRoom').doc(chatRoomId);
    final snapshot = await chatRoomRef.get();
    if (!snapshot.exists) {
      await handleOnCreateChatRoom(context);
    }
    Navigator.push(
        context,
        SlideLeftRoute(
            page: Chat(
          chatRoomId: chatRoomId,
          receiverId: receiverId,
          receiverName: userName,
          receiverPhone: receiverPhone,
        )));
  }

  @override
  Widget build(BuildContext context) {
    if (isCurrentUser) {
      return Container();
    } else {
      return GestureDetector(
        onTap: () => handleOnOpenChat(context),
        child: Card(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                    child: Text(userName.substring(0, 1).toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontFamily: 'OverpassRegular',
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(userName,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ),
      );
    }
  }
}
