import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_management/controllers/group_list/group_list.dart';
import 'package:tour_management/localization/localization.dart';
import 'package:tour_management/models/users_repo/users_repo.dart';

class FilterButton extends StatelessWidget {
  final bool visible;
  FilterButton({this.visible, Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.bodyText2;
    final activeStyle = Theme.of(context)
        .textTheme
        .bodyText2
        .copyWith(color: Theme.of(context).accentColor);
    return BlocBuilder<GroupListBloc, GroupListState>(
      builder: (context, state) {
        final button = _Button(
          onSelected: (filter) {
            BlocProvider.of<GroupListBloc>(context).add(FilterUpdated(filter));
          },
          activeFilter: state is GroupListLoaded
              ? state.groupFilter
              : VisibilityGroupFilter.all,
          activeStyle: activeStyle,
          defaultStyle: defaultStyle,
        );
        return AnimatedOpacity(
            opacity: visible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 150),
            child: visible ? button : IgnorePointer(child: button));
      },
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key key,
    @required this.onSelected,
    @required this.activeFilter,
    @required this.activeStyle,
    @required this.defaultStyle,
  }) : super(key: key);

  final PopupMenuItemSelected<VisibilityGroupFilter> onSelected;
  final VisibilityGroupFilter activeFilter;
  final TextStyle activeStyle;
  final TextStyle defaultStyle;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<VisibilityGroupFilter>(
      key: ArchSampleKeys.filterButton,
      onSelected: onSelected,
      itemBuilder: (BuildContext context) =>
          <PopupMenuItem<VisibilityGroupFilter>>[
        PopupMenuItem<VisibilityGroupFilter>(
          key: ArchSampleKeys.allFilter,
          value: VisibilityGroupFilter.all,
          child: Text(
            'Show All Users',
            style: activeFilter == VisibilityGroupFilter.all
                ? activeStyle
                : defaultStyle,
          ),
        ),
        PopupMenuItem<VisibilityGroupFilter>(
          key: ArchSampleKeys.guideTypeFilter,
          value: VisibilityGroupFilter.guide,
          child: Text(
            'Show guides',
            style: activeFilter == VisibilityGroupFilter.guide
                ? activeStyle
                : defaultStyle,
          ),
        ),
        PopupMenuItem<VisibilityGroupFilter>(
          key: ArchSampleKeys.participantTypeFilter,
          value: VisibilityGroupFilter.participant,
          child: Text(
            'Show participant',
            style: activeFilter == VisibilityGroupFilter.participant
                ? activeStyle
                : defaultStyle,
          ),
        ),
      ],
      icon: Icon(Icons.filter_list),
    );
  }
}
