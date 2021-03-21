import 'package:chpnt_repo_manager/chpnt_repo_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tour_management/localization/localization.dart';

//Widget for the checkpoint to be displayed
class CheckpointOfGuide extends StatelessWidget {
  final GestureTapCallback onTap;
  final ValueChanged<bool> onCheckboxChanged;
  final CheckpointModel chkpoint;
  final dateFormat = new DateFormat('yyyy-MM-dd HH:mm');
  CheckpointOfGuide(
      {Key key,
      @required this.onTap,
      @required this.onCheckboxChanged,
      @required this.chkpoint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: Checkbox(
            key: ArchSampleKeys.checkpointItemCheckbox(chkpoint.pointId),
            value: chkpoint.pointComplete,
            activeColor: Colors.redAccent,
            onChanged: onCheckboxChanged),
        title: Hero(
          tag: '${chkpoint.pointId}__heroTag',
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(chkpoint.pointName,
                key: ArchSampleKeys.checkpointName(chkpoint.pointId),
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ),
        ),
        subtitle: Text(
          dateFormat.format(chkpoint.pointDatetime),
          key: ArchSampleKeys.checkpointTime(chkpoint.pointId),
          style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: Colors.blueAccent),
        ),
        trailing: Icon(
          Icons.info,
          size: 25,
          color: Colors.blue,
        ),
      ),
    );
  }
}
