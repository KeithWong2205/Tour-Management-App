// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/widgets.dart';

class ArchSampleKeys {
  // Home Screens
  static const homeScreen = Key('__homeScreen__');
  static const addTodoFab = Key('__addTodoFab__');
  static const snackbar = Key('__snackbar__');
  static Key snackbarAction(String id) => Key('__snackbar_action_${id}__');

  // Todos
  static const checkpointList = Key('__todoList__');
  static const checkpointsLoading = Key('__todosLoading__');
  // ignore: unnecessary_brace_in_string_interps
  static final checkpointItem = (String id) => Key('TodoItem__${id}');
  static final checkpointItemCheckbox =
      (String id) => Key('TodoItem__${id}__Checkbox');
  static final checkpointName = (String id) => Key('TodoItem__${id}__Task');
  static final checkpointPlace = (String id) => Key('TodoItem__${id}__Place');
  static final checkpointTime = (String id) => Key('TodoItem__${id}__Time');
  static final checkpointNote = (String id) => Key('TodoItem__${id}__Note');

  // Details Screen
  static const editCheckpointFAB = Key('__editTodoFab__');
  static const deleteCheckpointButton = Key('__deleteTodoFab__');
  static const checkpointDetailsScene = Key('__todoDetailsScreen__');
  static final detailsCheckpointCheckbox = Key('DetailsTodo__Checkbox');
  static final detailsCheckpointName = Key('DetailsTodo__Task');
  static final detailsCheckpointPlace = Key('DetailsTodo__Place');
  static final detailsCheckpointTime = Key('DetailsTodo_Time');
  static final detailsCheckpointNote = Key('DetailsTodo__Note');

  // Add Screen
  static const addCheckpointScene = Key('__addTodoScreen__');
  static const saveNewCheckpoint = Key('__saveNewTodo__');
  static const nameField = Key('__taskField__');
  static const placeField = Key('__placeField__');
  static const timeField = Key('__timeField__');
  static const groupField = Key('__groupField__');
  static const noteField = Key('__noteField__');

  // Edit Screen
  static const editCheckpointScene = Key('__editTodoScreen__');
  static const saveCheckpointFAB = Key('__saveTodoFab__');
}
