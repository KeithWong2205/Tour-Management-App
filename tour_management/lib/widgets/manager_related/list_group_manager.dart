import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_management/styles/animation.dart';
import 'package:tour_management/views/manager/user_detail_scene.dart';
import 'package:tour_management/widgets/widgets.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:tour_management/controllers/group_list/group_list.dart';

class ListGroupManager extends StatelessWidget {
  ListGroupManager({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupListBloc, GroupListState>(
      // ignore: missing_return
      builder: (context, state) {
        if (state is GroupListLoaded) {
          final users = state.users;
          return GroupedListView(
            elements: users,
            groupBy: (element) => element.groupID,
            groupComparator: (value1, value2) => value1.compareTo(value2),
            itemComparator: (element1, element2) =>
                element1.name.compareTo(element2.name),
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
                        color: Colors.green,
                        border: Border.all(color: Colors.green),
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
              return UserItem(
                  user: element,
                  onTap: () => Navigator.push(
                      context,
                      SlideLeftRoute(
                          page: UserDetailScene(
                        id: element.id,
                      ))));
            },
          );
        } else if (state is GroupListLoadin) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
