import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tour_management/helper/FirebaseStorageHelper.dart';
import 'package:tour_management/models/users_repo/firestore_service.dart';
import 'package:tour_management/models/users_repo/user_model.dart';
import 'package:tour_management/styles/styles.dart';
import 'package:tour_management/widgets/widgets.dart';

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
      appBar: profileEditAppBar(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Container(
                    height: 250,
                    child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: const EdgeInsets.all(9),
                            child: GestureDetector(
                                onTap: () {
                                  _showPicker(context);
                                },
                                child: CircleAvatar(
                                    radius: 200,
                                    backgroundColor: Color(0xffFDCF09),
                                    child: _image != null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Image.file(
                                              _image,
                                              width: 200,
                                              height: 200,
                                              fit: BoxFit.fill,
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            width: 200,
                                            height: 200,
                                            child:CircleAvatar(
                                              backgroundImage: NetworkImage(widget._currentUserInfo.photoURL),
                                              radius: 200,
                                            )
                                    )))))),
                SizedBox(height: 10),
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
                SizedBox(height: 10),
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
