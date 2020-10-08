import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_management/localization/keys.dart';
import 'package:tour_management/views/views.dart';
import 'package:tour_management/widgets/widgets.dart';
import 'package:tour_management/controllers/chpnt_manager/chpnt_man.dart';
import 'package:tour_management/controllers/chpoint_list/chpoint_list.dart';

class ListCheckPoints extends StatelessWidget {
  ListCheckPoints({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckPointListBloc, CheckPointListState>(
      builder: (context, state) {
        if (state is CheckPointListLoaded) {
          final checkpoints = state.checkpoints;
          return Scaffold(
            body: ListView.builder(
              itemCount: checkpoints.length,
              itemBuilder: (BuildContext context, int index) {
                final checkpoint = checkpoints[index];
                return Checkpoint(
                  chkpoint: checkpoint,
                  onDismissed: (direction) {
                    BlocProvider.of<CheckpointManBloc>(context)
                        .add(CheckpointManDelete(checkpoint));
                    Scaffold.of(context).showSnackBar(CheckpointDeleteSnack(
                        checkpoint: checkpoint,
                        onUndo: () =>
                            BlocProvider.of<CheckpointManBloc>(context)
                                .add(CheckpointManAdded(checkpoint))));
                  },
                  onTap: () async {
                    final removedTodo = await Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) {
                      return CheckpointDetailScene(
                        id: checkpoint.pointId,
                      );
                    }));
                    if (removedTodo != null) {
                      Scaffold.of(context).showSnackBar(CheckpointDeleteSnack(
                          key: ArchSampleKeys.snackbar,
                          checkpoint: checkpoint,
                          onUndo: () =>
                              BlocProvider.of<CheckpointManBloc>(context)
                                  .add(CheckpointManDelete(checkpoint))));
                    }
                  },
                  onCheckboxChanged: (_) {
                    BlocProvider.of<CheckpointManBloc>(context).add(
                        CheckpointManUpdated(checkpoint.copyWith(
                            complete: !checkpoint.pointComplete)));
                  },
                );
              },
            ),
          );
        } else
          return CircularProgressIndicator();
      },
    );
  }
}
