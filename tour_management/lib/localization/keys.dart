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

  // Tabs
  static const tabs = Key('__tabs__');
  static const todoTab = Key('__todoTab__');
  static const statsTab = Key('__statsTab__');

  // Extra Actions
  static const extraActionsButton = Key('__extraActionsButton__');
  static const toggleAll = Key('__markAllDone__');
  static const clearCompleted = Key('__clearCompleted__');

  // Filters
  static const filterButton = Key('__filterButton__');
  static const allFilter = Key('__allFilter__');
  static const activeFilter = Key('__activeFilter__');
  static const completedFilter = Key('__completedFilter__');

  // Stats
  static const statsCounter = Key('__statsCounter__');
  static const statsLoading = Key('__statsLoading__');
  static const statsNumActive = Key('__statsActiveItems__');
  static const statsNumCompleted = Key('__statsCompletedItems__');

  // Details Screen
  static const editCheckpointFAB = Key('__editTodoFab__');
  static const deleteCheckpointButton = Key('__deleteTodoFab__');
  static const checkpointDetailsScene = Key('__todoDetailsScreen__');
  static final detailsTodoItemCheckbox = Key('DetailsTodo__Checkbox');
  static final detailsTodoItemTask = Key('DetailsTodo__Task');
  static final detailsTodoItemPlace = Key('DetailsTodo__Place');
  static final detailsTodoItemTime = Key('DetailsTodo_Time');
  static final detailsTodoItemNote = Key('DetailsTodo__Note');

  // Add Screen
  static const addCheckpointScene = Key('__addTodoScreen__');
  static const saveNewTodo = Key('__saveNewTodo__');
  static const nameField = Key('__taskField__');
  static const placeField = Key('__placeField__');
  static const timeField = Key('__timeField__');
  static const groupField = Key('__groupField__');
  static const noteField = Key('__noteField__');

  // Edit Screen
  static const editCheckpointScene = Key('__editTodoScreen__');
  static const saveCheckpointFAB = Key('__saveTodoFab__');
}