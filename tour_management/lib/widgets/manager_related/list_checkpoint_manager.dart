import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_management/localization/keys.dart';
import 'package:tour_management/styles/animation.dart';
import 'package:tour_management/views/views.dart';
import 'package:tour_management/widgets/widgets.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:tour_management/controllers/chpnt_manager/chpnt_man.dart';
import 'package:tour_management/controllers/chpoint_list/chpoint_list.dart';

class ListCheckPointsManager extends StatelessWidget {
  ListCheckPointsManager({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckPointListBloc, CheckPointListState>(
      // ignore: missing_return
      builder: (context, state) {
        if (state is CheckPointListLoaded) {
          final checkpoints = state.checkpoints;
          return GroupedListView(
            elements: checkpoints,
            groupBy: (element) => element.pointGroup,
            groupComparator: (value1, value2) => value1.compareTo(value2),
            itemComparator: (element1, element2) =>
                element1.pointDatetime.compareTo(element2.pointDatetime),
            order: GroupedListOrder.ASC,
            useStickyGroupSeparators: true,
            groupSeparatorBuilder: (value) => Container(
                color: Colors.grey[350],
                height: 80,
                child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        border: Border.all(color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            value,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontStyle: FontStyle.italic),
                          )),
                    ))),
            itemBuilder: (context, element) {
              return CheckpointOfManager(
                chkpoint: element,
                onDismissed: (direction) {
                  BlocProvider.of<CheckpointManBloc>(context)
                      .add(CheckpointManDelete(element));
                  // ignore: deprecated_member_use
                  Scaffold.of(context).showSnackBar(CheckpointDeleteSnack(
                      checkpoint: element,
                      onUndo: () => BlocProvider.of<CheckpointManBloc>(context)
                          .add(CheckpointManAdded(element))));
                },
                onTap: () async {
                  final removedTodo = await Navigator.push(
                      context,
                      SlideLeftRoute(
                          page: CheckpointDetailSceneManager(
                        id: element.pointId,
                      )));
                  if (removedTodo != null) {
                    // ignore: deprecated_member_use
                    Scaffold.of(context).showSnackBar(CheckpointDeleteSnack(
                        key: ArchSampleKeys.snackbar,
                        checkpoint: element,
                        onUndo: () =>
                            BlocProvider.of<CheckpointManBloc>(context)
                                .add(CheckpointManDelete(element))));
                  }
                },
                onCheckboxChanged: null,
              );
            },
          );
        } else if (state is CheckPointListLoadin) {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
