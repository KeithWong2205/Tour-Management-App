import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tour_management/helper/AppDataHelper.dart';
import 'package:tour_management/models/users_repo/firebase_service.dart';
import 'package:tour_management/views/conversation/helperfunctions.dart';
import 'package:tour_management/widgets/conversation_related/widgets.dart';

import 'chat.dart';

class Search extends StatefulWidget {
  final String currentUid;
  const Search({this.currentUid});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  FireBaseService firebaseService = FireBaseService();
  TextEditingController searchEditingController = new TextEditingController();
  QuerySnapshot searchResultSnapshot;

  bool isLoading = false;
  bool haveUserSearched = false;

  initiateSearch() async {
    if (searchEditingController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await firebaseService
          .searchByName(searchEditingController.text)
          .then((snapshot) {
        searchResultSnapshot = snapshot;
        searchResultSnapshot.docs
            .removeWhere((result) => result.data()['id'] == widget.currentUid);
        print("$searchResultSnapshot");
        setState(() {
          isLoading = false;
          haveUserSearched = searchResultSnapshot.docs.isNotEmpty;
        });
      });
    }
  }

  Widget userList() {
    return haveUserSearched
        ? Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: searchResultSnapshot.docs.length,
          itemBuilder: (context, index) {
            return userTile(
              searchResultSnapshot.docs[index].data()["name"],
              searchResultSnapshot.docs[index].data()["email"],
              searchResultSnapshot.docs[index].data()["id"],
            );
          }),
        )
        : Container();
  }

  /// 1.create a chatroom, send user to the chatroom, other userdetails
  sendMessage(String userId) {
    AppDataHelper.getUser().then((user) => handleSendMessage(user.id, userId));
  }

  void handleSendMessage(String uid1, String uid2) {
    List<String> users = [uid1, uid2]; // uid2 is receiverId

    String chatRoomId = HelperFunctions.createChatRoomId(uid1, uid2);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId": chatRoomId,
    };

    firebaseService.addChatRoom(chatRoom, chatRoomId);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Chat(
                  chatRoomId: chatRoomId,
                  receiverId: uid2,
                )));
  }

  Widget userTile(String userName, String userEmail, String userId) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 4.0),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16
                ),
              ),
              Text(
                userEmail,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16
                ),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              sendMessage(userId);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(width: 1.0,
                  color: Colors.white70),
                  borderRadius: BorderRadius.circular(24)
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            children: [
              Expanded(
                  child: Container(
                    height: 42.0,
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24.0),
                        border: Border.all(color: Colors.white70, width: 2.0)
                    ),
                    child: TextField(
                      controller: searchEditingController,
                      style: simpleTextStyle(),
                      decoration: InputDecoration(
                          hintText: "Search username ...",
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          border: InputBorder.none
                      ),
                    ),
                  )
              ),
              SizedBox(width: 8.0, height: 8.0,),
              GestureDetector(
                onTap: (){
                  initiateSearch();
                },
                child: Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              const Color(0x36FFFFFF),
                              const Color(0x0FFFFFFF)
                            ],
                            begin: FractionalOffset.topLeft,
                            end: FractionalOffset.bottomRight
                        ),
                        borderRadius: BorderRadius.circular(40)
                    ),
                    padding: EdgeInsets.all(12),
                    child: Image.asset("assets/search_white.png",
                      height: 24, width: 24,)),
              )
            ],
          ),
        ),
        elevation: 0.0,
      ),
      body: isLoading ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) :  Container(
        child: Column(
          children: [
            userList()
          ],
        ),
      ),
    );
  }
}
