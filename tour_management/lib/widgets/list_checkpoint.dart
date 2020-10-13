import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_management/localization/keys.dart';
import 'package:tour_management/views/views.dart';
import 'package:tour_management/widgets/widgets.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:tour_management/controllers/chpnt_manager/chpnt_man.dart';
import 'package:tour_management/controllers/chpoint_list/chpoint_list.dart';

class ListCheckPoints extends StatelessWidget {
  ListCheckPoints({Key key}) : super(key: key);
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
                element1.pointName.compareTo(element2.pointName),
            order: GroupedListOrder.ASC,
            useStickyGroupSeparators: true,
            groupSeparatorBuilder: (value) => Container(
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
              return Checkpoint(
                chkpoint: element,
                onDismissed: (direction) {
                  BlocProvider.of<CheckpointManBloc>(context)
                      .add(CheckpointManDelete(element));
                  Scaffold.of(context).showSnackBar(CheckpointDeleteSnack(
                      checkpoint: element,
                      onUndo: () => BlocProvider.of<CheckpointManBloc>(context)
                          .add(CheckpointManAdded(element))));
                },
                onTap: () async {
                  final removedTodo = await Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) {
                    return CheckpointDetailScene(
                      id: element.pointId,
                    );
                  }));
                  if (removedTodo != null) {
                    Scaffold.of(context).showSnackBar(CheckpointDeleteSnack(
                        key: ArchSampleKeys.snackbar,
                        checkpoint: element,
                        onUndo: () =>
                            BlocProvider.of<CheckpointManBloc>(context)
                                .add(CheckpointManDelete(element))));
                  }
                },
                onCheckboxChanged: (_) {
                  BlocProvider.of<CheckpointManBloc>(context).add(
                      CheckpointManUpdated(
                          element.copyWith(complete: !element.pointComplete)));
                },
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
