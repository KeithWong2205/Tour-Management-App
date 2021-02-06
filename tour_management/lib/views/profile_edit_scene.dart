import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tour_management/helper/FirebaseStorageHelper.dart';
import 'package:tour_management/models/users_repo/firestore_service.dart';
import 'package:tour_management/models/users_repo/user_model.dart';
import 'package:tour_management/styles/styles.dart';

class ProfileEditScene extends StatefulWidget {
  final UserModel _currentUserInfo;
  ProfileEditScene({Key key, UserModel userModel})
      : assert(userModel != null),
        this._currentUserInfo = userModel,
        super(key: key);
  @override
  _ProfileEditSceneState createState() => _ProfileEditSceneState();
}

class _ProfileEditSceneState extends State<ProfileEditScene> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode phoneField;
  File _image;
  TextEditingController _nameController;
  TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget._currentUserInfo.name);
    _phoneController =
        TextEditingController(text: widget._currentUserInfo.phone);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void updateUserInfo() async {
    if (formKey.currentState.validate()) {
      String photoURL = "";
      Map<String, dynamic> userMap =
          widget._currentUserInfo.toEntity().toDocument();
      if (_image != null) {
        photoURL = await FirebaseStorageHelper.uploadImage(file: _image);
      }
      userMap['name'] = _nameController.text;
      userMap['phone'] = _phoneController.text;
      userMap['photoURL'] = photoURL;
      await FireStoreService().createUser(UserModel.fromData(userMap));
      Navigator.pop(context);
    }
  }

  _imgFromCamera() async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Edit Profile", style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.amber,
        actions: [
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Icon(Icons.cancel, size: 24, color: Colors.white),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height / 3,
                    child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: const EdgeInsets.all(9),
                            child: GestureDetector(
                                onTap: () {
                                  _showPicker(context);
                                },
                                child: CircleAvatar(
                                    radius:
                                        MediaQuery.of(context).size.height / 7,
                                    child: _image != null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Image.file(
                                              _image,
                                              width: 300,
                                              height: 300,
                                              fit: BoxFit.fill,
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                                color: Colors.blueGrey[50],
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            width: 300,
                                            height: 300,
                                            child: CircleAvatar(
                                              child: widget._currentUserInfo
                                                          .photoURL !=
                                                      null
                                                  ? Image.network(widget
                                                      ._currentUserInfo
                                                      .photoURL)
                                                  : Icon(Icons.camera,
                                                      color: Colors.black,
                                                      size: 26),
                                              radius: 300,
                                              backgroundColor: Colors.grey,
                                            ))))))),
                Text('Tap on image to change',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
                SizedBox(height: 50),
                TextFormField(
                  decoration: profileNameFieldStyle(),
                  textInputAction: TextInputAction.next,
                  validator: (val) {
                    return val.trim().isEmpty ? 'A name is required' : null;
                  },
                  controller: _nameController,
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(phoneField),
                ),
                SizedBox(height: 50),
                TextFormField(
                  decoration: profilePhoneFieldStyle(),
                  textInputAction: TextInputAction.next,
                  validator: (val) {
                    return val.trim().isEmpty
                        ? 'A phone number is required'
                        : null;
                  },
                  controller: _phoneController,
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(new FocusNode()),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: updateUserInfo,
          icon: Icon(Icons.save),
          backgroundColor: Colors.amber,
          foregroundColor: Colors.white,
          label: Text('Save')),
    );
  }
}
