import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:chpnt_repo_manager/chpnt_repo_manager.dart';
import 'package:intl/intl.dart';
import 'package:tour_management/localization/keys.dart';
import 'package:tour_management/styles/styles.dart';

typedef OnSaveCallback = Function(String name, String groupID, String location,
    DateTime dateTime, String note);

class AddEditScene extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final CheckpointModel checkpoint;

  AddEditScene(
      {Key key,
      @required this.onSave,
      @required this.isEditing,
      this.checkpoint})
      : super(key: key ?? ArchSampleKeys.addCheckpointScene);
  @override
  _AddEditSceneState createState() => _AddEditSceneState();
}

class _AddEditSceneState extends State<AddEditScene> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name;
  String _groupID;
  String _location;
  DateTime _dateTime;
  String _note;
  final format = DateFormat("yyyy-MM-dd HH:mm");
  FocusNode groupField;
  FocusNode locationField;
  List<String> groupNames = [
    'Group 1',
    'Group 2',
    'Group 3',
    'Group 4',
    'Group 5'
  ];
  bool get isEditing => widget.isEditing;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.redAccent,
            title: Text(isEditing ? 'Checkpoint Edit' : 'Checkpoint Addition',
                style: TextStyle(fontSize: 24))),
        body: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
            child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                    key: _formKey,
                    child: ListView(children: [
                      Container(
                        height: 250,
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(9),
                            child: Container(
                              width: 450,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: checkpointNameFieldStyle(),
                        textInputAction: TextInputAction.next,
                        initialValue:
                            isEditing ? widget.checkpoint.pointName : '',
                        key: ArchSampleKeys.nameField,
                        autofocus: !isEditing,
                        validator: (val) {
                          return val.trim().isEmpty
                              ? 'A name is required'
                              : null;
                        },
                        onSaved: (value) => _name = value,
                        onFieldSubmitted: (value) =>
                            FocusScope.of(context).requestFocus(groupField),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField(
                        decoration: checkpointGroupFieldStyle(),
                        value:
                            isEditing ? widget.checkpoint.pointGroup : _groupID,
                        items: groupNames.map((groupName) {
                          return DropdownMenuItem(
                            value: groupName,
                            child: Text('$groupName'),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _groupID = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: checkpointLocationFieldStyle(),
                        textInputAction: TextInputAction.done,
                        initialValue:
                            isEditing ? widget.checkpoint.pointLocal : '',
                        key: ArchSampleKeys.placeField,
                        validator: (val) {
                          return val.trim().isEmpty
                              ? 'Location is required'
                              : null;
                        },
                        onSaved: (value) => _location = value,
                        onFieldSubmitted: (value) => FocusScope.of(context)
                            .requestFocus(new FocusNode()),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DateTimeField(
                        decoration: checkpointDateTimeFieldStyle(),
                        style: TextStyle(
                            fontSize: 18, fontStyle: FontStyle.italic),
                        format: format,
                        onShowPicker: (context, currentValue) async {
                          final date = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: isEditing
                                  ? widget.checkpoint.pointDatetime
                                  : DateTime.now(),
                              lastDate: DateTime(2100));
                          if (date != null) {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(isEditing
                                  ? widget.checkpoint.pointDatetime
                                  : DateTime.now()),
                            );
                            return _dateTime =
                                DateTimeField.combine(date, time);
                          } else {
                            return currentValue;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: checkpointNoteFieldStyle(),
                        initialValue:
                            isEditing ? widget.checkpoint.pointNote : '',
                        key: ArchSampleKeys.noteField,
                        maxLines: 10,
                        onSaved: (value) => _note = value,
                      )
                    ])))),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.red,
          key: isEditing
              ? ArchSampleKeys.editCheckpointFAB
              : ArchSampleKeys.saveCheckpointFAB,
          icon: Icon(isEditing ? Icons.check : Icons.save),
          foregroundColor: Colors.white,
          label: Text(isEditing ? 'Done' : 'Save'),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              widget.onSave(_name, _groupID, _location, _dateTime, _note);
              Navigator.pop(context);
            }
          },
        ));
  }
}
