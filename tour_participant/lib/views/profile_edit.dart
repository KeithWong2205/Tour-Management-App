import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tour_participant/helper/FirebaseStorageHelper.dart';
import 'package:tour_participant/models/student_repo/student_repo.dart';
import 'package:tour_participant/widgets/widgets.dart';
import 'package:tour_participant/styles/styles.dart';

class ProfileEditPage extends StatefulWidget {
  final UserModel _currUserInfo;
  ProfileEditPage({Key key, UserModel userModel})
      : assert(userModel != null),
        this._currUserInfo = userModel,
        super(key: key);
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode phoneField;
  File _image;
  TextEditingController _nameFieldController;
  TextEditingController _phoneFieldController;

  @override
  void initState() {
    super.initState();
    _nameFieldController =
        TextEditingController(text: widget._currUserInfo.name);
    _phoneFieldController =
        TextEditingController(text: widget._currUserInfo.phone);
  }

  @override
  void dispose() {
    _nameFieldController.dispose();
    _phoneFieldController.dispose();
    super.dispose();
  }

  void updateUserInfo() async {
    if (formKey.currentState.validate()) {
      String photoURL = "";
      Map<String, dynamic> userMap =
          widget._currUserInfo.toEntity().toDocument();
      if (_image != null) {
        photoURL = await FirebaseStorageHelper.uploadImage(file: _image);
      }
      userMap['name'] = _nameFieldController.text;
      userMap['phone'] = _phoneFieldController.text;
      userMap['photoURL'] = photoURL;
      await FireStoreService().createStudent(UserModel.fromData(userMap));
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
                                            child: Icon(
                                              Icons.camera_alt,
                                              color: Colors.grey[800],
                                            ))))))),
                SizedBox(height: 10),
                TextFormField(
                  decoration: profileNameFieldStyle(),
                  textInputAction: TextInputAction.next,
                  validator: (val) {
                    return val.trim().isEmpty ? 'A name is required' : null;
                  },
                  controller: _nameFieldController,
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
                  controller: _phoneFieldController,
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
